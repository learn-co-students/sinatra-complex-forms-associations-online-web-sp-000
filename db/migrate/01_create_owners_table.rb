class CreateOwnersTable < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end