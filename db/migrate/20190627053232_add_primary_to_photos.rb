class AddPrimaryToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :primary, :boolean
  end
end
