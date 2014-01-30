class FixColumnNameCourses < ActiveRecord::Migration
  def change
    rename_column :courses, :sub_course, :sub_category
  end
end
