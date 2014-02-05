class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :student_id
      t.integer :exam_center_id
      t.integer :machine_id
      t.integer :course_id
      t.date :exam_date
      t.time :exam_start_time
      t.time :exam_end_time
      t.date :registration_date
      t.integer :no_of_attempts

      t.timestamps
    end
  end
end
