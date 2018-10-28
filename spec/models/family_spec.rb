require 'rails_helper'

RSpec.describe Family, type: :model do

  describe '家族メンバーが存在するかを返す' do
    context '家族メンバーが0人のとき' do
      it '存在しないと判定すること' do
        family = FactoryBot.create(:family)
        expect(family).not_to be_member
      end
    end

    context '家族メンバーが1人以上のとき' do
      it '存在すると判定すること' do
        family = FactoryBot.create(:family, :with_members)
        expect(family).to be_member
      end
    end
  end

  describe 'からだ情報が存在するかを返す' do
    context 'からだ情報が0個のとき' do
      it '存在しないと判定すること' do
        family = FactoryBot.create(:family)
        expect(family).not_to be_body
      end
    end

    context 'からだ情報が1個以上のとき' do
      it '存在すると判定すること' do
        family = FactoryBot.create(:family, :with_bodies)
        expect(family).to be_body
      end
    end
  end

  context '招待中のユーザーが0人のとき' do
    it '招待中ユーザーは空が返ること' do
      family = FactoryBot.create(:family, :with_members)
      expect(family.invitees).to eq []
    end

    it '招待中ユーザーは存在しないと判定されること' do
      family = FactoryBot.create(:family, :with_members)
      expect(family.invitee?).to be_falsey
    end
  end

  context '招待中のユーザーが1人以上いるとき' do
    it '家族メンバーに招待中のユーザーを含めないこと' do
      family = FactoryBot.create(:family, :with_members, :with_invitees,
                                 member_count: 1, invitee_count: 1)
      expect(family.members.count).to be 1
      expect(family.members).not_to include family.invitees
    end

    it '招待中ユーザーには家族メンバーを含めないこと' do
      family = FactoryBot.create(:family, :with_members, :with_invitees,
                                 member_count: 1, invitee_count: 1)
      expect(family.invitees.count).to be 1
      expect(family.invitees).not_to include family.members
    end

    it '招待中ユーザーは存在する判定されること' do
      family = FactoryBot.create(:family, :with_members, :with_invitees)
      expect(family.invitee?).to be_truthy
    end
  end

  describe '家族を削除する' do
    it '家族メンバーも同時に削除すること' do
      family = FactoryBot.create(:family, :with_members)
      original_count = family.members.count
      expect do
        family.destroy!
      end.to change(User, :count).by(-original_count)
    end

    it 'からだ情報も同時に削除すること' do
      family = FactoryBot.create(:family, :with_bodies)
      original_count = family.bodies.count
      expect do
        family.destroy!
      end.to change(Body, :count).by(-original_count)
    end
  end
end
