class AddColumnToBlocked < ActiveRecord::Migration[5.1]
  def change
    add_reference :blockeds, :user, type: :uuid
    add_column :blockeds, :blockee_id, :string
  end
end
