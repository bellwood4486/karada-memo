class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :destroy

  def destroy
    @user.destroy!
    redirect_to family_url
  end

  private

  def set_user
    @user = current_user.family.users.find(params[:id])
  end
end
