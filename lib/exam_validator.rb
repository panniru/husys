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
    pass_percent = (right_answers.to_f/exam.no_of_questions)*100
    if pass_percent >= exam.pass_criteria_1
      exam.pass_text_1
    elsif exam.pass_criteria_2.present? and pass_percent >= exam.pass_criteria_2 and pass_percent < exam.pass_criteria_1
      exam.pass_text_2
    elsif exam.pass_criteria_3.present? and pass_percent >= exam.pass_criteria_3 and pass_percent < exam.pass_criteria_2
      exam.pass_text_3
    elsif exam.pass_criteria_4.present? and pass_percent >= exam.pass_criteria_4 and pass_percent < exam.pass_criteria_3
      exam.pass_text_4
    else
      "FAIL"
    end
  end
end
