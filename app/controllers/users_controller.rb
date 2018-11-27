class UsersController < ApplicationController
  before_action :authenticate_user!

  def destroy
    # 招待中だったら消せるような validation が欲しい
    @user = current_user.family.users.find(params[:id])
    @user.destroy!
    redirect_to family_url
  end
end
