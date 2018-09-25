require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe 'create' do
    it '自分と無関係なからだに対してメモを追加しようした場合、例外をスローすること #51' do
      user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:user)
      body_of_other_user = FactoryBot.create(:body, family: other_user.family)
      note_params = FactoryBot.attributes_for(:note)
      sign_in user
      expect do
        post :create, params: {
          # ログインユーザーとは紐づかない「からだ」を指定する
          note: note_params.merge!(body_id: body_of_other_user.id)
        }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
