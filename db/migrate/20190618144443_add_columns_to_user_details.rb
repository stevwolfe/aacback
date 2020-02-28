class AddColumnsToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :description, :text
    add_column :user_details, :marital_status, :string
    add_column :user_details, :occupation, :string
    add_column :user_details, :income, :integer
    add_reference :users, :user_details, type: :uuid

  end
end
