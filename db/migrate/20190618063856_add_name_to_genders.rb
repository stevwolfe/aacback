class AddNameToGenders < ActiveRecord::Migration[5.1]
  def change
    add_column :genders, :name, :string
  end
end
