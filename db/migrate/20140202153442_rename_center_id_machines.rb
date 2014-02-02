class RenameCenterIdMachines < ActiveRecord::Migration
  def change
    rename_column :machines, :center_id, :exam_center_id
  end
end
