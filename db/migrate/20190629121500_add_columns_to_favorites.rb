class AddColumnsToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_reference :favorites, :user, type: :uuid
    add_column :favorites, :favorite_id, :string
  end
end
