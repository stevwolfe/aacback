class CreateUserConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_conversations, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :conversation, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
