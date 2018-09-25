class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body, only: %i[create update]
  before_action :set_note, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
    # 追加先のからだがクエリパラメータに指定されるケースと、未指定のケースの2通りがあるため
    # find_byで「からだ」を取得する。nilは未指定として扱う。
    body_or_nil = current_user.family.bodies.find_by(id: params[:body_id])
    @note = Note.new(body: body_or_nil)
  end

  def edit
  end

  def create
    # current_userと無関係なからだにメモが追加されないようにbody_idを直接渡すのではなく
    # オブジェクトとして取得しておいてそれを渡す。(updateも同様)
    @note = Note.new(note_params.merge!(body: @body))
    if @note.save
      redirect_to @note, success: 'メモを作成しました'
    else
      render :new
    end
  end

  def update
    if @note.update(note_params.merge!(body: @body))
      redirect_to @note, success: 'メモを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy!
    redirect_to @note.body, success: 'メモを削除しました'
  end

  private

  def set_body
    @body = current_user.family.bodies.find(params[:note][:body_id])
  end

  def set_note
    @note = current_user.family.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:detail, :noted_at)
  end
end
