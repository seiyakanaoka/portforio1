class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.text :address
      t.float :latitude
      t.float :longitude
      t.text :title
      t.text :comment
      t.integer :user_id
      t.integer :log_id

      t.timestamps
    end
  end
end