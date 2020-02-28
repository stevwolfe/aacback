class ChangeUrlnamePhotos < ActiveRecord::Migration[5.1]
  def change
    rename_column :photos, :url_gleeden, :remote_url
  end
end
