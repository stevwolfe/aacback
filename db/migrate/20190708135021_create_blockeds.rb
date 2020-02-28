class CreateBlockeds < ActiveRecord::Migration[5.1]
  def change
    create_table :blockeds, id: :uuid do |t|

      t.timestamps
    end
  end
end
