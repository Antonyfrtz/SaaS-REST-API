class CreateGroupConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :group_conversations do |t|

      t.timestamps
    end
  end
end
