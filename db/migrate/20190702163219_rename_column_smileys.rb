class RenameColumnSmileys < ActiveRecord::Migration[5.1]
  def change
    rename_column :smileys, :sender, :receiver
  end
end
