class ChangeColumnTypeInRules < ActiveRecord::Migration[6.0]
  def change
    change_column :rules, :voice_chat_id, :integer
  end
end
