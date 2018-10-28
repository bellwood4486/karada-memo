# frozen_string_literal: true

class FamiliesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @family = current_user.family
  end
end
