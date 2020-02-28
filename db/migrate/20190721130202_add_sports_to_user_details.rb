class AddSportsToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :aerobics, :boolean
    add_column :user_details, :golf, :boolean
    add_column :user_details, :martial_arts, :boolean
    add_column :user_details, :soccer, :boolean
    add_column :user_details, :walking, :boolean
    add_column :user_details, :rugby, :boolean
    add_column :user_details, :swimming, :boolean
    add_column :user_details, :baseball, :boolean
    add_column :user_details, :cycling, :boolean
    add_column :user_details, :running, :boolean
    add_column :user_details, :tennis, :boolean
    add_column :user_details, :weight, :boolean
    add_column :user_details, :basketball, :boolean
    add_column :user_details, :dance, :boolean
    add_column :user_details, :skiing, :boolean
    add_column :user_details, :volleyball, :boolean
  end
end
