class LogsController < ApplicationController
  def new
  end

  def create
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def log_params
    params.require(:log).permit(:image, :title, :body, :weather, :water_temperature, :dive_number, :dive_depth, :dive_point)
  end

end
