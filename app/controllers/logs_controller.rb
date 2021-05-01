class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

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
    @logcomment = LogComment.new
  end

  def edit
    if @log.user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @log.update(log_params)
    redirect_to log_path(@log)
  end

  def destroy
    @log.destroy
    redirect_to logs_path
  end

  private

  def set_log
    @log = Log.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:log_image, :title, :body, :weather, :water_temperature, :dive_number, :dive_depth, :dive_point)
  end

end
