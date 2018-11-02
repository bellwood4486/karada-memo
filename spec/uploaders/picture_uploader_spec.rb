require 'rails_helper'

RSpec.describe PictureUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  let(:note) { FactoryBot.create(:note) }
  let(:uploader) { PictureUploader.new(note, :picture) }

  before :all do
    PictureUploader.enable_processing = true
  end

  after :all do
    PictureUploader.enable_processing = false
  end

  after do
    # 各テストケースでアップロードされた画像を削除(なければ何もしない)
    uploader.remove!
  end

  describe '画像のデフォルトURLを返す' do
    it 'オリジナル画像のデフォルトURLを返せること' do
      expect(uploader.default_url).to eq '/images/fallback/default.png'
    end

    it 'サムネイルバージョンのデフォルトURLも返せること' do
      expect(uploader.thumb.default_url).to eq '/images/fallback/thumb_default.png'
    end
  end

  describe '画像をアップロードする' do
    it 'アップロードされる画像は読み取り専用(オーナーのみ)であること' do
      uploader.store!(fixture_file_upload('1x1.png', 'image/png'))
      expect(uploader).to have_permissions(0o600)
    end
  end

  describe 'オリジナル画像をリサイズする' do
    before do
      uploader.store!(fixture_file_upload(original_picture, 'image/png'))
    end

    context 'オリジナル画像が800x800以上のとき' do
      let(:original_picture) { '801x801.png' }

      it '800x800に縮小すること' do
        expect(uploader).to have_dimensions(800, 800)
      end
    end

    context 'オリジナル画像が800x800未満のとき' do
      let(:original_picture) { '799x799.png' }

      it 'そのままのサイズにしておくこと' do
        expect(uploader).to have_dimensions(799, 799)
      end
    end
  end

  describe 'サムネイルバージョンを生成する' do
    before do
      uploader.store!(fixture_file_upload(original_picture, 'image/png'))
    end

    context 'オリジナル画像が400x400以上のとき' do
      let(:original_picture) { '401x401.png' }

      it '400x400に縮小したサムネイルバージョンを生成すること' do
        expect(uploader.thumb).to have_dimensions(400, 400)
      end
    end

    context 'オリジナル画像が400x400未満のとき' do
      let(:original_picture) { '399x399.png' }

      it '400x400に拡大したムネイルバージョンを生成すること' do
        expect(uploader.thumb).to have_dimensions(400, 400)
      end
    end
  end

  describe 'ファイル名を固定長の名前にリネームする' do
    it '「10桁の英数字+拡張子」のファイル名にリネームすること' do
      uploader.store!(fixture_file_upload('1x1.png', 'image/png'))
      expect(uploader.file.original_filename).to match(/^\w{10}.\w+$/)
    end
  end

  describe 'アップロードを許す拡張子を返す' do
    it '許可する拡張子は、jpg, jpeg, png, gifのみであること' do
      expect(uploader.extension_whitelist).to match_array(%w[jpg jpeg png gif])
    end
  end

  describe 'アップロード可能なサイズを返す' do
    it '最少サイズは1Bであること' do
      expect(uploader.size_range.min).to eq 1
    end

    it '最大サイズは5MBのみであること' do
      expect(uploader.size_range.max).to eq 5.megabyte
    end
  end
end
