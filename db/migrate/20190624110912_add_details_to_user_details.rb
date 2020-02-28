class AddDetailsToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :birthday, :datetime
    add_column :user_details, :looking_exciting, :boolean
    add_column :user_details, :looking_long, :boolean
    add_column :user_details, :looking_anything, :boolean
    add_column :user_details, :looking_short, :boolean
    add_column :user_details, :looking_undecided, :boolean
    add_column :user_details, :looking_virtual, :boolean
    add_column :user_details, :height, :integer
    add_column :user_details, :hair_color, :string
    add_column :user_details, :eye_color, :string
    add_column :user_details, :smoker, :boolean
  end
end
