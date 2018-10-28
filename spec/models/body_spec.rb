require 'rails_helper'

RSpec.describe Body, type: :model do
  describe 'からだを検証する' do
    it '有効なファクトリを持つこと' do
      expect(FactoryBot.build(:body)).to be_valid
    end

    it 'ニックネームがなければ無効な状態であること' do
      body = FactoryBot.build(:body, nickname: nil)
      body.valid?
      expect(body.errors[:nickname]).to include('を入力してください')
    end

    it '最大長のニックネームは有効であること' do
      body = FactoryBot.build(:body, nickname: 'a' * 50)
      expect(body).to be_valid
    end

    it '最大長+1文字のニックネームは無効であること' do
      body = FactoryBot.build(:body, nickname: 'a' * (50 + 1))
      body.valid?
      expect(body.errors[:nickname]).to include('は50文字以内で入力してください')
    end

    it '同一家族内で重複したニックネームなら無効な状態であること' do
      body1 = FactoryBot.create(:body, nickname: 'duplicate')
      body2 = FactoryBot.build(:body, nickname: 'duplicate',
                                      family: body1.family)
      body2.valid?
      expect(body2.errors[:nickname]).to include('はすでに存在します')
    end

    it '別家族内で重複したニックネームなら有効な状態であること' do
      FactoryBot.create(:body, nickname: 'duplicate')
      body2 = FactoryBot.build(:body, nickname: 'duplicate')
      expect(body2).to be_valid
    end
  end

  describe 'からだを削除する' do
    it 'ノートも一緒に削除すること' do
      body = FactoryBot.create(:body, :with_notes)
      original_count = body.notes.count
      expect do
        body.destroy!
      end.to change(Note, :count).by(-original_count)
    end
  end
end
