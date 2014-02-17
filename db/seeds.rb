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
    admin =  User.new({:email => 'admin@ostryalabs.com', :password => 'welcome', :user_id => 'admin'})
    admin.role = role
    admin.save!
  end

  unless student.present?
    student =  User.new({:email => 'student@ostryalabs.com', :password => 'welcome', :user_id => 'student'})
    student.role = stu_role
    student.save!
  end

  unless exam_center.present?
    exam_center =  User.new({:email => 'exam_center@ostryalabs.com', :password => 'welcome', :user_id => 'exam_center'})
    exam_center.role = exam_center_role
    exam_center.save!
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

def seed_all
  seed_role
  seed_user
  seed_exam_center
end

seed_all
