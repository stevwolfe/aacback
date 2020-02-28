class AddUseridToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_reference :photos, :user, type: :uuid
  end
end
