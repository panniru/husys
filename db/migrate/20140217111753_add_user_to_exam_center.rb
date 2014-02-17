class AddUserToExamCenter < ActiveRecord::Migration
  def change
    add_column :exam_centers, :assigned_user_id, :integer
  end
end
