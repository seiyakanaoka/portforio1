class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :dive_profile, :follow, :follower]

  def show
    if @user.id == current_user.id
      render :my_page
    end
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomid = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to my_page_user_path(current_user.id)
    else
      render :edit
    end
  end

  def my_page
    @user = User.find(current_user.id)
  end

  def unsubscribe
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def dive_profile
    @log = @user.logs
  end

  def follow
    @follow = @user.following_user
  end

  def follower
    @follower = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :nick_name, :introduction, :license_rank, :best_point, :best_point_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
