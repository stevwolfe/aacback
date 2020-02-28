class CreateUserDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :user_details, id: :uuid do |t|

      t.timestamps
    end
  end
end
