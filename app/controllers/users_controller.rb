class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def update
  end

  def my_page
    @user = User.find(current_user.id)
  end

  def unsubscribe
  end

  def withdraw
  end

  def dive_profile
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
