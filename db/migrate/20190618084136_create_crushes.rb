class CreateCrushes < ActiveRecord::Migration[5.1]
  def change
    create_table :crushes, id: :uuid do |t|
      t.references :user, type: :uuid

      t.timestamps
    end
  end
end
