class LogCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @log = Log.find(params[:log_id])
    @comment = current_user.log_comments.new(comment_params)
    @comment.log_id = @log.id
    if @comment.save
      # 通知機能
      @log.create_notification_comment!(current_user, @comment.id)
    else
      render 'logs/show'
    end
  end

  def destroy
    @destroy = LogComment.find_by(id: params[:id], log_id:params[:log_id]).destroy.id
  end

  private

  def comment_params
    params.require(:log_comment).permit(:comment, :reply_comment)
  end

end
