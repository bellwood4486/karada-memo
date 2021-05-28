class BodiesController < ApplicationController
  before_action :set_body, only: %i[show edit update destroy]
  before_action :set_bodies, only: %i[index select]

  def index
  end

  def new
    @body = Body.new
  end

  def edit
  end

  def create
    @body = current_user.family.bodies.build(body_params)
    if @body.save
      redirect_to family_url, success: 'からだを作成しました'
    else
      render :new
    end
  end

  def update
    if @body.update(body_params)
      redirect_to family_url, success: 'からだを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @body.destroy!
    redirect_to family_url, success: 'からだを削除しました'
  end

  def select
    render 'select_nobody' if @bodies.empty?
  end

  private

  def set_body
    @body = current_user.family.bodies.find(params[:id])
  end

  def set_bodies
    # orderあってもよいね
    @bodies = current_user.family.bodies
  end

  def body_params
    params.require(:body).permit(:nickname)
  end
end
