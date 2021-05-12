class BookmarksController < ApplicationController
   before_action :authenticate_user!

  def create
    @log = Log.find(params[:log_id])
    bookmark = @log.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @log = Log.find(params[:log_id])
    bookmark = @log.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
end
