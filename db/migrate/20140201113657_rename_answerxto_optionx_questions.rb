class RenameAnswerxtoOptionxQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :answer_1, :option_1
    rename_column :questions, :answer_2, :option_2
    rename_column :questions, :answer_3, :option_3
    rename_column :questions, :answer_4, :option_4
    rename_column :questions, :correct_answer, :answer
  end
end
