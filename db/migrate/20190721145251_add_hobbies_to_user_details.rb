class AddHobbiesToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :arts, :boolean
    add_column :user_details, :cooking, :boolean
    add_column :user_details, :hiking, :boolean
    add_column :user_details, :networking, :boolean
    add_column :user_details, :video_games, :boolean
    add_column :user_details, :book, :boolean
    add_column :user_details, :dining_out, :boolean
    add_column :user_details, :movies, :boolean
    add_column :user_details, :nightclubs, :boolean
    add_column :user_details, :religion, :boolean
    add_column :user_details, :charities, :boolean
    add_column :user_details, :museums, :boolean
    add_column :user_details, :shopping, :boolean
    add_column :user_details, :wine, :boolean
    add_column :user_details, :coffee, :boolean
    add_column :user_details, :gardening, :boolean
    add_column :user_details, :pets, :boolean
    add_column :user_details, :music, :boolean
  end
end
