class AddLookingphotosmembersToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :looking_photos_members, :boolean
  end
end
