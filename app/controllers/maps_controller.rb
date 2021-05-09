class MapsController < ApplicationController

  def index
    @map = Map.new
    @maps = Map.all
  end

  def create
    @user = User.find(params[:user_id])
    @map = Map.new(map_params)
    if @map.save
      redirect_to edit_user_path(@user)
    else
      @maps = Map.all
      render 'maps/index'
    end
  end

  private

  def map_params
    params.require(:map).permit(:address, :latitude, :longitude, :title, :comment)
  end

end
