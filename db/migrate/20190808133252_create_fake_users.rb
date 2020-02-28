class CreateFakeUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :fake_users, id: :uuid do |t|
      t.string :photo
      t.integer :age
      t.string :member_gender

      t.timestamps
    end
  end
end
