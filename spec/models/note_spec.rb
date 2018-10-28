require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'ノートを検証する' do
    it '有効なファクトリを持つこと' do
      expect(FactoryBot.build(:note)).to be_valid
    end

    it '記録日時がなければ無効な状態であること' do
      note = FactoryBot.build(:note, noted_at: nil)
      note.valid?
      expect(note.errors[:noted_at]).to include('を入力してください')
    end

    it '最大長の詳細は有効であること' do
      note = FactoryBot.build(:note, detail: 'a' * 1000)
      expect(note).to be_valid
    end

    it '最大長+1文字の詳細は無効であること' do
      note = FactoryBot.build(:note, detail: 'a' * (1000 + 1))
      note.valid?
      expect(note.errors[:detail]).to include('は1000文字以内で入力してください')
    end
  end

  describe 'ノートを作成する' do
    context '記録日時が未指定のとき' do
      it '現在時刻を記録日時に設定すること' do
        attrs = FactoryBot.attributes_for(:note)
        attrs.delete(:noted_at)
        note = Note.new(attrs)
        expect(note.noted_at).not_to be_nil
      end
    end

    context '記録日時が指定されているとき' do
      it '指定された日時を記録日時に設定すること' do
        yesterday = 1.day.ago
        note = FactoryBot.create(:note, noted_at: yesterday)
        expect(note.noted_at).to eq yesterday
      end
    end

    it 'selectで最少のidだけに限定して、ノートlモデルを取得してもインスタンスが作られること #34' do
      note = FactoryBot.create(:note)
      found_note = Note.select(:id).find(note.id)
      expect(found_note.id).to eq note.id
    end
  end

  describe 'ページング用の集合を返す' do
    it 'デフォルトでは6つのメモを返す' do
      7.times { FactoryBot.create(:note) }
      expect(Note.all.page.size).to eq 6
    end
  end
end
