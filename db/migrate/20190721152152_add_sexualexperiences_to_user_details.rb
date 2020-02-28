class AddSexualexperiencesToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :being_blinded, :boolean
    add_column :user_details, :costume, :boolean
    add_column :user_details, :role_playing, :boolean
    add_column :user_details, :using_sex_toys, :boolean
    add_column :user_details, :unusual_places, :boolean
    add_column :user_details, :being_watched, :boolean
    add_column :user_details, :willing_experiment, :boolean
  end
end
