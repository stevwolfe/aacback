class AddScheduledloginsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :scheduled_log_in, :datetime
    add_column :users, :scheduled_log_out, :datetime
  end
end
