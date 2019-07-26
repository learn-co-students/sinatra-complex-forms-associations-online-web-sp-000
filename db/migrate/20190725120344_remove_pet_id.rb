class RemovePetId < ActiveRecord::Migration
  def change
    remove_column :owners, :pet_id, :integer
  end
end
