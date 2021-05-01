class LogCommentsController < ApplicationController

  def create
    @log = Log.find(params[:log_id])
    @comment = current_user.log_comments.new(comment_params)
    @comment.log_id = @log.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    LogComment.find_by(id: params[:id], log_id:params[:log_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:log_comment).permit(:comment)
  end

end
