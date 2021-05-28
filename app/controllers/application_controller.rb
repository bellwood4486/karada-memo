# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user! # ほとんどの画面でログイン必要だと思うので、全体でかけちゃって、いらないところで skip するのが良さそう
  before_action :set_family
  add_flash_types :success, :info, :warning, :danger

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = '管理者用ページです。権限があるアカウントでログインしてください。'
      redirect_to root_url
    end
  end

  def set_family
    @family = current_user.family
  end
end
