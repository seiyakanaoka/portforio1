class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :log_image_id
      t.string :title
      t.text :body
      t.integer :weather
      t.integer :water_temperature
      t.integer :dive_number
      t.integer :dive_depth
      t.string :dive_point
      t.string :hashbody
      t.integer :impressions_count, default: 0

      t.timestamps
    end
  end
end
