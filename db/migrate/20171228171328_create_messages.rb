class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.string :text
      t.references :user, type: :uuid, foreign_key: true
      t.references :conversation, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
