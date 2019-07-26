class AddPetId < ActiveRecord::Migration
  def change
    add_column :owners, :pet_id, :integer
  end
end
