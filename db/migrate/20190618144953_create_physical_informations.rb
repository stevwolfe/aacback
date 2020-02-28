class CreatePhysicalInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :physical_informations, id: :uuid do |t|
      t.integer :height
      t.string :ethnicity
      t.string :hair_color
      t.string :eye_color
      t.boolean :smoker
      t.timestamps
    end
  end
end
