class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :zip_code, :integer
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :relationship_status_id, :integer
  end
end
