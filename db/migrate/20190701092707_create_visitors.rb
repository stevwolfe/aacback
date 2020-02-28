class CreateVisitors < ActiveRecord::Migration[5.1]
  def change
    create_table :visitors, id: :uuid do |t|

      t.timestamps
    end
  end
end
