class NewColumnsFakeUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :fake_users, :users, type: :uuid
    add_reference :fake_users, :user_details, type: :uuid
  end
end
