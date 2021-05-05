class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorites, only: [:create, :destroy]

  def create
    @favorite = current_user.favorites.new(log_id: @log.id)
    @favorite.save
  end

  def destroy
    @favorite = current_user.favorites.find_by(log_id: @log.id)
    @favorite.destroy
  end

  private

  def set_favorites
    @log = Log.find(params[:log_id])
  end

end
