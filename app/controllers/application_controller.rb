# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = '管理者用ページです。権限があるアカウントでログインしてください。'
      redirect_to root_url
    end
  end
end
