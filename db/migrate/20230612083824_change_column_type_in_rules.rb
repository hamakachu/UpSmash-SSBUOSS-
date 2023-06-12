class ChangeColumnTypeInRules < ActiveRecord::Migration[6.0]
  def up
    change_column :rules, :voice_chat_id, :integer
  end

  def down
    change_column :rules, :voice_chat_id, :string
  end
end
