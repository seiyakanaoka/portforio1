class CreateDirects < ActiveRecord::Migration[5.2]
  def change
    create_table :directs do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :room_id
      t.integer :message_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    add_index :directs, :visitor_id
    add_index :directs, :visited_id
    add_index :directs, :room_id
    add_index :directs, :message_id
  end
end
