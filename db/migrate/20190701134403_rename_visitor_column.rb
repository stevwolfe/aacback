class RenameVisitorColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :visitors, :visitor_id, :visitee_id
  end
end
