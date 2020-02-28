class AddPersonalityToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :active, :boolean
    add_column :user_details, :shy, :boolean
    add_column :user_details, :sociable, :boolean
    add_column :user_details, :modest, :boolean
    add_column :user_details, :fun, :boolean
    add_column :user_details, :generous, :boolean
    add_column :user_details, :spiritual, :boolean
    add_column :user_details, :moody, :boolean
    add_column :user_details, :relaxed, :boolean
    add_column :user_details, :sensitive, :boolean
  end
end
