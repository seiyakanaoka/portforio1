class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorites, only: [:create, :destroy]

  def create
    @favorite = current_user.favorites.new(log_id: @log.id)
    @favorite.save
    # ここから
    @log.create_notification_favorite!(current_user)
    # ここまで
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
