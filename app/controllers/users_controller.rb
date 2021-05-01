class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def edit
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
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :nick_name, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
