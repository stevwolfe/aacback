class AddLookingonlinemembersToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :looking_online_members, :boolean
  end
end
