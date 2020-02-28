class AddUrlgleedenToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :url_gleeden, :string
    add_column :photos, :string, :string
  end
end
