class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos, id: :uuid do |t|
      t.string :url

      t.timestamps
    end
  end
end
