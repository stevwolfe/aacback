class AddPeronalitiesToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :cultivated, :boolean
    add_column :user_details, :imaginative, :boolean
    add_column :user_details, :independent, :boolean
    add_column :user_details, :mature, :boolean
    add_column :user_details, :outgoing, :boolean
    add_column :user_details, :self_confident, :boolean
    add_column :user_details, :reliable, :boolean
    add_column :user_details, :sophisticated, :boolean
  end
end
