class AddReferenceToPhysicalInformations < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :physical_informations, type: :uuid
  end
end
