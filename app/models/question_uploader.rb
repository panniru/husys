require 'roo'

class QuestionUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :question_file
  attr_accessor :course_id

  def initialize(attributes = {})
    attributes.each{|name, value| send("#{name}=", value ) }
  end

  def persisted?
    false
  end

  def save
    if imported_questions.map(&:valid?).all?
      imported_questions.each(&:save!)
      true
    else
      imported_questions.each.with_index do |question, index|
        question.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2} : #{message}"
        end
      end
      false
    end
  end

  def imported_questions
    @imported_questions ||= import
  end

  def import
    spreadsheet = open_spreadsheet(question_file)

    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.merge!("course_id" => course_id)
      question = Question.find_by_id(row["id"]) || Question.new
      question.attributes = row.to_hash.slice("description", "option_1", "option_2", "option_3", "option_4", "answer", "course_id")
      question
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
