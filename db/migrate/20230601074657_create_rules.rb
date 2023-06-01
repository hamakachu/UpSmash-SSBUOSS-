class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.integer :format_id, null: false
      t.integer :match_count_id, null: false
      t.string :voice_chat_id, null: false
      t.string :discord
      t.string :room_code, null: false
      t.integer :room_pass, null: false
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
