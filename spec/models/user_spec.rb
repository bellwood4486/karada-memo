# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーを検証する' do
    it '有効なファクトリを持つこと' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it 'ニックネームがなければ無効な状態であること' do
      user = FactoryBot.build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include('を入力してください')
    end

    it '最大長のニックネームは有効であること' do
      user = FactoryBot.build(:user, nickname: 'a' * 50)
      expect(user).to be_valid
    end

    it '最大長+1文字のニックネームは無効であること' do
      user = FactoryBot.build(:user, nickname: 'a' * (50 + 1))
      user.valid?
      expect(user.errors[:nickname]).to include('は50文字以内で入力してください')
    end

    it 'メールアドレスがなければ無効な状態であること' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'パスワードがなければ無効な状態であること' do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it '重複したメールアドレスなら無効な状態であること' do
      FactoryBot.create(:user, email: 'duplicate@exmaple.com')
      user = FactoryBot.build(:user, email: 'duplicate@exmaple.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end

  describe 'ユーザーを作成する' do
    it 'ユーザーモデルが作られると同時に新しい家族モデルが作ること' do
      user = FactoryBot.create(:user)
      expect(user.family).not_to be_nil
    end

    it 'ユーザーモデルが検索で取得されたときは既存の家族モデルを関連付けること' do
      user = FactoryBot.create(:user)
      found_user = User.find(user.id)
      expect(found_user.family).to eq user.family
    end

    it 'selectで最少のidだけに限定して、ユーザーモデルを取得してもインスタンスが作られること #34' do
      user = FactoryBot.create(:user)
      found_user = User.select(:id).find(user.id)
      expect(found_user.id).to eq user.id
    end
  end

  describe 'ユーザーを削除する' do
    context '家族に一人のユーザーしか存在しないとき' do
      it '家族モデルも同時に削除すること' do
        user = FactoryBot.create(:user)
        expect do
          user.destroy!
        end.to change(Family, :count).by(-1)
      end
    end

    context '家族に二人以上のユーザーが存在するとき' do
      it '家族モデルは削除せずに対象ユーザーだけ削除する' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:user, family: user.family)
        expect do
          user.destroy!
        end.not_to change(Family, :count)
      end
    end
  end

  describe '管理者権限を持つか判定する' do
    it '管理者権限があるユーザーならtrueを返すこと' do
      user = FactoryBot.build(:user)
      user.add_role :admin
      expect(user).to be_admin
    end

    it '管理者権限がないユーザーならfalseを返すこと' do
      user = FactoryBot.build(:user)
      expect(user).not_to be_admin
    end
  end
end
