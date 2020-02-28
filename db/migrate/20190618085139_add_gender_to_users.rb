class AddGenderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :genders, type: :uuid
  end
end
