class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :birthdate, :datetime
    add_column :users, :min_age, :integer
    add_column :users, :max_age, :integer
    add_column :users, :max_radius, :integer
    add_column :users, :last_login, :datetime
    add_column :users, :last_logout, :datetime

  end
end
