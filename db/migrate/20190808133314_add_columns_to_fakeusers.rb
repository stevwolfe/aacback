class AddColumnsToFakeusers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :fake_users, type: :uuid
    add_reference :user_details, :fake_users, type: :uuid
  end
end
