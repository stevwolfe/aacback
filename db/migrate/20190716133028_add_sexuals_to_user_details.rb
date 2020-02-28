class AddSexualsToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :anything_goes, :boolean
    add_column :user_details, :being_dominated, :boolean
    add_column :user_details, :dominating, :boolean
    add_column :user_details, :normal, :boolean
    add_column :user_details, :threesome, :boolean
    add_column :user_details, :secret, :boolean
  end
end
