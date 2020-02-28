class AddColumnsToRelationshipStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :relationship_statuses, :description, :string
  end
end
