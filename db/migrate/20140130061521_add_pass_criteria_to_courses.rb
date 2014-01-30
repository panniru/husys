class AddPassCriteriaToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :pass_criteria_1, :string
    add_column :courses, :pass_text_1, :string
    add_column :courses, :pass_criteria_2, :string
    add_column :courses, :pass_text_2, :string
    add_column :courses, :pass_criteria_3, :string
    add_column :courses, :pass_text_3, :string
    add_column :courses, :pass_criteria_4, :string
    add_column :courses, :pass_text_4, :string
  end
end
