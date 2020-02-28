class AddConfirmeduserToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirmed_user, :boolean
  end
end