class DirectsController < ApplicationController
  before_action :authenticate_user!
  def index
    @directs = current_user.passive_directs.page(params[:page]).per(20)
  end
end
