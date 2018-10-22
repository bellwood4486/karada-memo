class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body, only: %i[index new create]
  before_action :set_note, only: %i[show edit update destroy]
  before_action :set_year, only: :index

  def index
    @notes = @body.notes.noted_in(@year).page params[:page]
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
      redirect_to @note, success: 'メモを作成しました'
    else
      render :new
    end
  end

  def update
    @note.body = find_my_own_body(params[:note][:body_id])
    if @note.update(note_params)
      redirect_to @note, success: 'メモを更新しました'
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
    @note = current_user.family.notes.find(params[:id])
  end

  def set_year
    @year = params[:year]
  end

  def note_params
    params.require(:note).permit(:detail, :noted_at)
  end

  def find_my_own_body(body_id)
    current_user.family.bodies.find(body_id)
  end
end
