class AddHeightDetailsToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :inches, :integer
    add_column :user_details, :feet, :integer
  end
end
