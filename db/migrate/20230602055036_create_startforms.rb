class CreateStartforms < ActiveRecord::Migration[6.0]
  def change
    create_table :startforms do |t|
      t.boolean :executed, null: false, default: false
      t.text :reason, null: false
      t.text :action_plan, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
