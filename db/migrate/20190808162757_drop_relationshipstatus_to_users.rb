class DropRelationshipstatusToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :relationship_status_id
  end
end
