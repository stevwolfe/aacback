class AddColumnsToRelationshipSoughts < ActiveRecord::Migration[5.1]
  def change
    add_column :relationship_soughts, :exciting, :boolean
    add_column :relationship_soughts, :long_term, :boolean
    add_column :relationship_soughts, :anything, :boolean
    add_column :relationship_soughts, :short_term, :boolean
    add_column :relationship_soughts, :undecided, :boolean
    add_column :relationship_soughts, :virtual, :boolean
    add_reference :users, :relationship_soughts, type: :uuid
  end
end
