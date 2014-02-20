class ExamValidator
  include Virtus.model
  attribute :active_questions
  attribute :registration
  attribute :course

  def initialize(active_questions, registration, course)
    self.active_questions = active_questions
    self.registration = registration
    self.course = course
  end

  def self.rule_engine
    @rule_engine ||= RuleEngine.new
  end

  CUTOFF = rule_engine.value(:exam, :cutoff).to_i
  NEGATIVE_MARK = rule_engine.value(:exam, :negative_mark)
  POSITIVE_MARK = rule_engine.value(:exam, :positive_mark)

  def validate
    right_answers = 0
    active_questions.each do |act_qtn|
      question = Question.find(act_qtn.question_id)
      right_answers +=1 if question.answer == act_qtn.answer_caught
    end
    status = right_answers >= CUTOFF ? "passed" : "failed"
    pass_text = analyse_result(right_answers)
    result = Result.new(:registration_id => registration.id, :total_marks => course.no_of_questions, :marks_secured => right_answers, :exam_result => status, :pass_text => pass_text)
    result.save
    registration.do_post_result
    result
  end

  private

  def analyse_result(right_answers)
    pass_percent = (right_answers.to_f/course.no_of_questions)*100
    result = nil
    case pass_percent
    when course.pass_criteria_1.to_i..100
      result = "Distinction"
    when course.pass_criteria_2.to_i..course.pass_criteria_1.to_i
      result = "First Class"
    when course.pass_criteria_3.to_i..course.pass_criteria_2.to_i
      result = "Average"
    when course.pass_criteria_4.to_i..course.pass_criteria_3.to_i
      result = "Passed"
    else
      result = "Failed"
    end
    result
  end
end
