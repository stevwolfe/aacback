class AddColumnsToVisitors < ActiveRecord::Migration[5.1]
  def change
    add_reference :visitors, :user, type: :uuid
    add_column :visitors, :vistor_id, :string
  end
end
