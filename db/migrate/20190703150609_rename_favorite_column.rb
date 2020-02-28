class RenameFavoriteColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :favorites, :favorite_id, :favorite_of
  end
end
