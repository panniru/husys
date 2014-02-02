class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :machine_id
      t.integer :center_id
      t.string :status

      t.timestamps
    end
  end
end
