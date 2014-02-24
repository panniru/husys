class CreateDescriptiveQuestions < ActiveRecord::Migration
  def change
    create_table :descriptive_questions do |t|
      t.integer :course_id
      t.string :description
      t.string :answer

      t.timestamps
    end
  end
end
