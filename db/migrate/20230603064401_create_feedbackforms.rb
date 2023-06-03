class CreateFeedbackforms < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbackforms do |t|
      t.integer :evaluation, null: false
      t.text :good, null: false
      t.text :bad, null: false
      t.text :next_action, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
