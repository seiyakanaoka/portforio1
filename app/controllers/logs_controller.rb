class LogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
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
    impressionist(@log, nil, :unique => [:session_hash.to_s])
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
    p '@@@@@@@@@@@@@@@@@@@@'
    @log.destroy
    redirect_to logs_path
  end

  def hashtag
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.logs.count}
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @log = @hashtag.logs.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.logs.count}
    end
  end

  private

  def set_log
    @log = Log.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:log_image, :title, :body, :weather, :water_temperature, :dive_number, :dive_depth, :dive_point, :hashbody, hashtag_ids: [])
  end

end
