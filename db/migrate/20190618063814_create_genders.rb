class CreateGenders < ActiveRecord::Migration[5.1]
  def change
    create_table :genders, id: :uuid do |t|

      t.timestamps
    end
  end
end
