class LogsController < ApplicationController
  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    @log.user_id = current_user.id
    @log.save
    redirect_to logs_path
  end

  def index
    @logs = Log.all
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
    params.require(:log).permit(:log_image, :title, :body, :weather, :water_temperature, :dive_number, :dive_depth, :dive_point)
  end

end
