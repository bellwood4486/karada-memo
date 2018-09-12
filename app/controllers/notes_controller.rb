class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body
  before_action :set_note, only: %i[show edit update destroy]
  before_action :set_year, only: :index
  before_action :set_js_variables_for_form, only: %i[new edit]

  def index
    @notes = @body.notes.order(noted_at: :desc).noted_in(@year).page params[:page]
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = @body.notes.build(note_params)
    if @note.save
      redirect_to [@note.body, @note], success: 'メモを作成しました'
    else
      render :new
    end
  end

  def update
    @note.body = find_my_own_body(params[:note][:body_id])
    if @note.update(note_params)
      redirect_to [@note.body, @note], success: 'メモを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy!
    redirect_to body_notes_url(@note.body), success: 'メモを削除しました'
  end

  private

  def set_body
    @body = find_my_own_body(params[:body_id])
  end

  def set_note
    @note = @body.notes.find(params[:id])
  end

  def set_year
    @year = params[:year]
  end

  def set_js_variables_for_form
    gon.picture_size_limit = PictureUploader::SIZE_LIMIT
  end

  def note_params
    params.require(:note).permit(:detail, :noted_at, :picture, :remove_picture)
  end

  def find_my_own_body(body_id)
    current_user.family.bodies.find(body_id)
  end
end
