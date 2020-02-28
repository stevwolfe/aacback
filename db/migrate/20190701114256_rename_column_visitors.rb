class RenameColumnVisitors < ActiveRecord::Migration[5.1]
  def change
    rename_column :visitors, :vistor_id, :visitor_id
  end
end
