class AddNewsportsToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :bowling, :boolean
    add_column :user_details, :hockey, :boolean
  end
end
