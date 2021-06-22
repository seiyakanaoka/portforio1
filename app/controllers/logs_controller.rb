class LogsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_log, only: %i[edit update destroy]

  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    @log.user_id = current_user.id
    if @log.save
      redirect_to logs_path, notice: 'You have created log successfully.'
    else
      render :new
    end
  end

  def index
    @logs = Log.all.includes(:user)
  end

  def show
    @log = Log.includes(log_comments: %i[user replies]).find(params[:id])
    @logcomment = LogComment.new
    gon.log = @log
    impressionist(@log, nil, unique: [:session_hash.to_s])
  end

  def edit
    if @log.user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    if @log.update(log_params)
      redirect_to log_path(@log)
    else
      render :edit
    end
  end

  def destroy
    @log.destroy
    redirect_to logs_path
  end

  def hashtag
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.logs.count }
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @log = @hashtag.logs.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.logs.count }
      binding.pry
    end
  end

  private

  def set_log
    @log = Log.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:log_image, :title, :body, :weather, :water_temperature, :dive_number, :dive_depth,
                                :dive_point, :hashbody, :address, :latitude, :longitude)
  end
end
