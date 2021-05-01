class CreateLogComments < ActiveRecord::Migration[5.2]
  def change
    create_table :log_comments do |t|
      t.integer :user_id
      t.integer :log_id
      t.text :comment

      t.timestamps
    end
  end
end
