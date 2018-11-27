class HomeController < ApplicationController
  def index
    redirect_to bodies_url if user_signed_in? # before_actionでやってもよいね
  end
end
