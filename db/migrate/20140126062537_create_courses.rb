class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_id
      t.string :course_name
      t.string :category
      t.string :sub_course
      t.string :exam_name
      t.float :duration
      t.integer :no_of_questions

      t.timestamps
    end
  end
end
