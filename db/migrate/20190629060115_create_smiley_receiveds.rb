class CreateSmileyReceiveds < ActiveRecord::Migration[5.1]
  def change
    create_table :smiley_receiveds, id: :uuid do |t|

      t.timestamps
    end
  end
end
