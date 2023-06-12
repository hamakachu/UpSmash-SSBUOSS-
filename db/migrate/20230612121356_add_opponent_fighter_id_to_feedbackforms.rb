class AddOpponentFighterIdToFeedbackforms < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbackforms, :opponent_fighter_id, :integer
  end
end
