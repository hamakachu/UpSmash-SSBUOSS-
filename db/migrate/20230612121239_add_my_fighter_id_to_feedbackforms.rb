class AddMyFighterIdToFeedbackforms < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbackforms, :my_fighter_id, :integer
  end
end
