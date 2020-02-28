class AddCroppedurlToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :cropped_url, :string
  end
end
