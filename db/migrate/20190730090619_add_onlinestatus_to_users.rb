class AddOnlinestatusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :manually_online, :boolean
  end
end
