class AddUseridToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_details, :user, type: :uuid
  end
end
