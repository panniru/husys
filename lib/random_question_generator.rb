class RandomQuestionGenerator

  def self.generate_question(prev_active_quests, course)
    total_questions = course.questions.all.length
    random_no = Random.rand(1..total_questions)
    while include_question?(random_no, prev_active_quests) do
      random_no = Random.rand(1..total_questions)
    end
    question = Question.find(random_no)
    return nil unless question
    ActiveQuestion.new(:question_id => question.id, :active_question_no => prev_active_quests.length+1, :description => question.description, :option_1 => question.option_1, :option_2 => question.option_2, :option_3 => question.option_3, :option_4 => question.option_4)
  end


  def self.include_question?(active_no, questions)
    matched_questions = questions.select {|question| question.question_id == active_no}
    matched_questions.length > 0
  end

  class ActiveQuestion
    include Virtus.model
    attribute :question_id, Integer
    attribute :answer_caught
    attribute :active_question_no, Integer
    attribute :description
    attribute :option_1
    attribute :option_2
    attribute :option_3
    attribute :option_4
  end
end
