class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_name, null: false
      t.references :host_user, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end