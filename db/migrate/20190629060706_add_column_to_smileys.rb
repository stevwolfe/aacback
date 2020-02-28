class AddColumnToSmileys < ActiveRecord::Migration[5.1]
  def change
    add_reference :smileys, :user, type: :uuid
    add_column :smileys, :sender, :string
  end
end
