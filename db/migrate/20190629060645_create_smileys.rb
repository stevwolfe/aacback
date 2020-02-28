class CreateSmileys < ActiveRecord::Migration[5.1]
  def change
    create_table :smileys, id: :uuid do |t|

      t.timestamps
    end
  end
end
