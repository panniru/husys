# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'

def seed_role
  role = Role.where(:code => 'admin').first_or_create!(role: "admin", description: "Super Admin")
  role = Role.where(:code => 'student').first_or_create!(role: "student", description: "Student")
  role = Role.where(:code => 'exam_center').first_or_create!(role: "exam_center", description: "Exam Center")
end

def seed_user
  role = Role.find_by_code("admin")
  stu_role = Role.find_by_code("student")
  exam_center_role = Role.find_by_code("exam_center")

  admin = User.where(user_id: "admin").first
  student = User.where(user_id: "student").first
  exam_center = User.where(user_id: "exam_center").first

  unless admin.present?
    admin =  User.new({:email => 'admin@ostryalabs.com', :password => 'welcome', :user_id => 'admin', :name => 'Admin'})
    admin.role = role
    admin.save!
  end

  unless student.present?
    student =  User.new({:email => 'student@ostryalabs.com', :password => 'welcome', :user_id => 'student', :name => 'Student'})
    student.role = stu_role
    student.save!
  end

  unless exam_center.present?
    exam_center =  User.new({:email => 'exam_center@ostryalabs.com', :password => 'welcome', :user_id => 'exam_center', :name => 'ExamCenter'})
    exam_center.role = exam_center_role
    exam_center.save!
  end

end

def seed_exam
  course = Course.first
  unless course.present?
    course = FactoryGirl.build(:course)
    course.save!
  end
end

def seed_questions
  course = Course.first
  unless Question.first.present?
    Question.create(course_id: course.id, description: "Who was known as Iron man of India?", option_1: "Govind Ballabh Pant", option_2: "Jawaharlal Nehru", option_3: "Subhash Chandra Bose", option_4: "Sardar Vallabhbhai Patel", answer: "Sardar Vallabhbhai Patel")
    Question.create(course_id: course.id, description: "Jude Felix is a famous Indian player in which of the fields?", option_1: "Volleyball", option_2: "Tennis", option_3: "Football", option_4: "Hockey", answer: "Hockey")
    Question.create(course_id: course.id, description: "Who invented the BALLPOINT PEN?", option_1: "Biro Brothers", option_2: "Waterman Brothers", option_3: "Bicc Brothers", option_4: "Write Brothers", answer: "Biro Brothers")
    Question.create(course_id: course.id, description: "Which scientist discovered the radioactive element radium?", option_1: "Isaac Newton", option_2: "Albert Einstein", option_3: "Benjamin Franklin", option_4: "Marie Curie", answer: "Marie Curie")
    Question.create(course_id: course.id, description: "What Galileo invented?", option_1: "Barometer", option_2: "Pendulum clock", option_3: "Microscope", option_4: "Thermometer", answer: "Thermometer")
    Question.create(course_id: course.id, description: "This statesman, politican, scholar, inventor, and one of early presidents of USA invented the swivel chair, the spherical sundial, the moldboard plow, and the cipher wheel.", option_1: "George Washington", option_2: "Alexander Hamilton", option_3: "John Adams", option_4: "Thomas Jefferson", answer: "Thomas Jefferson")
    Question.create(course_id: course.id, description: "The Battle of Plassey was fought in", option_1: "1757.0", option_2: "1782.0", option_3: "1748.0", option_4: "1764.0", answer: "1757.0")
    Question.create(course_id: course.id, description: "The members of the Rajya Sabha are elected by", option_1: "the people", option_2: "Lok Sabha", option_3: "elected members of the legislative assembly", option_4: "elected members of the legislative council", answer: "elected members of the legislative assembly")
    Question.create(course_id: course.id, description: "The present Lok Sabha is the", option_1: "13th Lok Sabha", option_2: "14th Lok Sabha", option_3: "15th Lok Sabha", option_4: "16th Lok Sabha", answer: "15th Lok Sabha")
    Question.create(course_id: course.id, description: "The famous Dilwara Temples are situated in", option_1: "Uttar Pradesh", option_2: "Rajasthan", option_3: "Maharashtra", option_4: "Madhya Pradesh", answer: "Rajasthan")
    Question.create(course_id: course.id, description: "The words 'Satyameva Jayate' inscribed below the ba...", option_1: "Rigveda", option_2: "Satpath Brahmana", option_3: "Mundak Upanishad", option_4: "Ramayana", answer: "Mundak Upanishad")
    Question.create(course_id: course.id, description: "Which was the 1st non Test playing country to beat India in an international match?", option_1: " Canada", option_2: "Zimbabwe", option_3: "Sri Lanka", option_4: "East Africa", answer: "Sri Lanka")
    Question.create(course_id: course.id, description: "The nucleus of an atom consists of", option_1: "electrons and neutrons", option_2: "electrons and protons", option_3: "protons and neutrons", option_4: "  All of the above", answer: "protons and neutrons")
    Question.create(course_id: course.id, description: "'OS' computer abbreviation usually means ?", option_1: "Order of Significance", option_2: "Open Software", option_3: "Operating System", option_4: "Optical Sensor", answer: "Operating System")
    Question.create(course_id: course.id, description: "Look at this series: 2, 1, (1/2), (1/4), ... What n...", option_1: "(1/3)", option_2: "(1/8)", option_3: "(2/8)", option_4: "(1/16)", answer: "(1/8)")
  end
end

def seed_exam_center
  center = ExamCenter.first
  user = User.where(user_id: "exam_center").first
  unless center.present?
    ExamCenter.create({:center_name => 'Head Office', :address_line1 => 'IIIT', :address_line2 => 'Gachibowli', :city => 'Hyderabad', :state => 'Andra Pradesh', :assigned_user_id =>  user.id})
    ExamCenter.create({:center_name => 'Head Office', :address_line1 => 'Image Hospital Madhapur Hyderabad', :assigned_user_id =>  user.id })
  end
end

def seed_machine
  machine = Machine.first
  unless machine.present?
    machine = FactoryGirl.build(:machine)
    machine.exam_center = ExamCenter.first
    machine.save!
  end
end

def seed_registration
  reg = Registration.first
  unless reg.present?
    student = User.where(user_id: "student").first
    course = Course.first
    exam_center = ExamCenter.first
    machine = exam_center.machines.first
    exam_date = DateTime.now+1
    registration_date = DateTime.now
    reg = Registration.new(student_id: student.id, exam_center_id: exam_center.id, machine_id: machine.id, course_id: course.id, exam_date: exam_date, exam_start_time: "11:00:00", exam_end_time: "11:30:00", registration_date: registration_date, status: "seeded", access_password: "welcome", registration_id: "demo 123")
    reg.save
  end
end

def seed_all
  seed_role
  seed_user
  seed_exam
  seed_exam_center
  seed_questions
  seed_machine
  seed_registration
end

seed_all
