class AddReplyUserIdToLogComment < ActiveRecord::Migration[5.2]
  def change
    add_column :log_comments, :reply_comment, :int
  end
end
