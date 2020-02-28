class CreateRelationshipSoughts < ActiveRecord::Migration[5.1]
  def change
    create_table :relationship_soughts, id: :uuid do |t|

      t.timestamps
    end
  end
end
