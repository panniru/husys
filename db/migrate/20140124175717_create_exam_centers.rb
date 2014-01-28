class CreateExamCenters < ActiveRecord::Migration
  def change
    create_table :exam_centers do |t|
      t.string :center_name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :country
      t.string :pin
      t.string :center_email
      t.string :phone
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
