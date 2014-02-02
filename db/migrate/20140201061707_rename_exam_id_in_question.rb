class RenameExamIdInQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :exam_id, :course_id
  end
end
