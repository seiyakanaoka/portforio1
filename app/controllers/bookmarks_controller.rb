class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @log = Log.find(params[:log_id])
    bookmark = @log.bookmarks.new(user_id: current_user.id)
    bookmark.save
  end

  def destroy
    @log = Log.find(params[:log_id])
    bookmark = @log.bookmarks.find_by(user_id: current_user.id)
    bookmark.destroy
  end
end
