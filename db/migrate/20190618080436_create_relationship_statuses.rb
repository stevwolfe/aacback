class CreateRelationshipStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :relationship_statuses, id: :uuid do |t|

      t.timestamps
    end
  end
end
