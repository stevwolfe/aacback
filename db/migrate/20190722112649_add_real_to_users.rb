class AddRealToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :real, :boolean
  end
end
