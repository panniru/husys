require 'roo'

class QuestionUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :descriptive_question_file
  attr_accessor :question_file
  attr_accessor :course_id

  def initialize(attributes = {})
    attributes.each{|name, value| send("#{name}=", value ) }
  end

  def persisted?
    false
  end

  def save
    status = false
    ActiveRecord::Base.transaction do
      if question_file.present?
        status = save_questions(imported_questions, question_file.original_filename)
      end

      if descriptive_question_file.present?
        status = save_questions(imported_descriptive_questions, descriptive_question_file.original_filename)
      end
      unless status
        raise ActiveRecord::Rollback
      end
    end
    status
  end

  def save_questions(questions, file_name)
    if questions.map(&:valid?).all?
      questions.each(&:save!)
      true
    else
      questions.each.with_index do |question, index|
        question.errors.full_messages.each do |message|
          errors.add :base, "#{file_name} Row #{index+2} : #{message}"
        end
      end
      false
    end
  end

  def imported_questions
    @imported_questions ||= import(question_file) do |row|
      question = Question.find_by_id(row["id"]) || Question.new
      question.attributes = row.to_hash.slice("description", "option_1", "option_2", "option_3", "option_4", "answer", "course_id")
      question
    end

  end

  def imported_descriptive_questions
    @imported_descriptive_questions ||= import(descriptive_question_file) do |row|
      question = DescriptiveQuestion.find_by_id(row["id"]) || DescriptiveQuestion.new
      question.attributes = row.to_hash.slice("description", "answer", "course_id")
      question
    end
  end

  def import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.merge!("course_id" => course_id)
      yield row
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
