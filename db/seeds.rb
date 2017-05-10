# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning the tables.."

Attendance.destroy_all
Grade.destroy_all
Assignment.destroy_all
Student.destroy_all
SchoolClass.destroy_all
User.destroy_all

puts "Building user..."

spencer = User.create(
  first_name: "Spencer",
  last_name: "Bray",
  email: "spencer@teacher.com",
  password: "password",
  password_confirmation: "password"
  )

puts "User built!"
puts "Building classes..."


class1 = SchoolClass.create(
      name: "Grade 3",
      description: "Half the students were transferred this year as their old school was closed. Remember they're new in town!
      Need extra attention in Math.",
      user: spencer
      )

class2 = SchoolClass.create(
      name: "Grade 5",
      description: "Really rowdy group, remember your classroom control techniques.
      They absolutely love stories about famous Nigerians in history!",
      user: spencer
  )

puts "Classes built!"

student_attributes = [
  {
    first_name: "Bisi",
    last_name: "Adeleye-Fayemi",
    bio: "Bisi comes from a small village in the rural north, she's really shy but very bright.",
    birthday: Faker::Date.birthday(6, 12),
    school_class: class1
    },
  {
    first_name: "Olisa",
    last_name: "Agbakoba",
    bio: "Olisa has trouble focusing during class. She tends to bother other students and can be a distraction. She is very good at math.",
    birthday: Faker::Date.birthday(6, 12),
    school_class: class1
    },
  {
    first_name: "Ayodele",
    last_name: "Awojobi",
    bio: "Ayodele loves reading. His parents were recently divorced, so he has been acting out in class.",
    birthday: Faker::Date.birthday(6, 12),
    school_class: class1
    },
  {
    first_name: "Gani",
    last_name: "Fawehinmi",
    bio: "Gani is an exceptionally good student who loves science.  He always talks about wanting to become a doctor. Encourage him!",
    birthday: Faker::Date.birthday(6, 12),
    school_class: class2
    },
  {
    first_name: "Dele",
    last_name: "Giwa",
    bio: "Dele is an animal lover. Make sure to remember that his dog's name is 'Billy'!",
    birthday: Faker::Date.birthday(6, 12),
    school_class: class1
    },
  {
    first_name: "Beko",
    last_name: "Ransome-Kuti",
    bio: "Beko wants to be a surgeon. He has already tried to practice his surgery on one of his classmates - leading to a reprimand from the headmaster.",
    birthday: Faker::Date.birthday(6, 12),
    school_class: class2
    },
  {
    first_name: "Olikoye",
    last_name: "Ransome-Kuti",
    bio: "Olikoye's parents are extremely poor, he comes to class hungry most days. Bringing an extra snack for him will help keep him focused.",
    birthday: Faker::Date.birthday(6, 12),
    school_class: class1
    },
]

Student.create!(student_attributes)

puts "Students added!"

assignment_attributes = [
  {
    name: "Homework 1",
    category: "Math",
    date: Time.now,
    max_points: 50,
    weight: 1,
    school_class: class1
    },
  {
    name: "Homework 2",
    category: "Math",
    date: Time.now,
    max_points: 40,
    weight: 1,
    school_class: class1
  },
  {
    name: "Test 1",
    category: "Math",
    date: Time.now,
    max_points: 100,
    weight: 2,
    school_class: class1
  },
  {
    name: "Worksheet 1",
    category: "English",
    date: Time.now,
    max_points: 30,
    weight: 1,
    school_class: class1
  },
  {
    name: "Worksheet 2",
    category: "English",
    date: Time.now,
    max_points: 40,
    weight: 1,
    school_class: class1
  },
  {
    name: "Midterm Eval",
    category: "Math",
    date: Time.now,
    max_points: 200,
    weight: 1,
    school_class: class1
  }
]

puts "Adding assignments to classes..."
Assignment.create!(assignment_attributes)
puts "Assignments added!"

puts "Adding a grade to each assignment for each student..."
Assignment.where(school_class: class1).each do |assignment|
  Student.where(school_class: class1).each do |student|
    Grade.create(
      earned_points: rand(assignment.max_points-20..assignment.max_points),
      student_id: student.id,
      assignment_id: assignment.id
      )
  end
end

puts "Grades added!"

date_range = []
i = 0
10.times do
  date_range << Date.today - i
  i += 1
end

puts "For all classes but first: Adding an attendance for each student for past 10 days..."
Student.where(school_class: class2).each do |student|
  date_range.each do |date|
    new_attendance = Attendance.new(student_id: student.id, date: date)
    new_attendance.present = [true, true, true, false].sample
    new_attendance.save
  end
end

puts "Attendances added for all classes but first!"

puts "For first class only!! Adding an attendance for each student for past 10 days except today..."
school_class = SchoolClass.first
Student.where(school_class_id: school_class.id).each do |student|
  date_range.last(9).each do |date|
    new_attendance = Attendance.new(student_id: student.id, date: date)
    new_attendance.present = [true, true, true, false].sample
    new_attendance.save
  end
end
puts "Attendances added for 'Grade 1'!"
