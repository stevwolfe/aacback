class AddPrivateToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :private, :boolean
  end
end
