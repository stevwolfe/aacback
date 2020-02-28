class AddDeactivatecolumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reason_deactivate, :string
    add_column :users, :comment_deactivate, :string
  end
end
