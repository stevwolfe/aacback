class AddNewcolumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email, :string
    add_column :users, :age, :integer
    add_column :users, :member_gender, :string
    add_column :users, :gender_interest, :string
  end
end
