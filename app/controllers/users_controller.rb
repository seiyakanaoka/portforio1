class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :dive_profile]

  def show
  end

  def edit
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def unsubscribe
  end

  def withdraw
  end

  def dive_profile
    @log = @user.logs
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :nick_name, :introduction, :license_rank, :best_point)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
