class CreateHashtagLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_logs do |t|
      t.references :log, foreign_key: true, index: true
      t.references :hashtag, foreign_key: true, index: true

      t.timestamps
    end
  end
end
