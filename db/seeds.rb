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

puts "Building users..."

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "test@test.com",
  password: "password!",
  password_confirmation: "password!"
  )

u = 1
4.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "test#{u}@test.com",
    password: "password!",
    password_confirmation: "password!"
    )
  u += 1
end

puts "Users built!"
puts "Building classes..."

i = 1
5.times do
  2.times do
    SchoolClass.create(
      name: "#{rand(4..12)}th Grade",
      description: Faker::StarWars.quote,
      user_id: i
      )
  end
  i += 1
end

puts "Classes built!"


SchoolClass.all.each_with_index do |school_class, index|
  puts "Adding students to class #{index + 1}..."
  rand(18..21).times do
    Student.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      bio: Faker::HarryPotter.quote,
      birthday: Faker::Date.birthday(6, 12),
      school_class_id: school_class.id
      )
  end
  puts "Students added!"

  puts "Adding assignments to class #{index + 1}..."
  10.times do
    Assignment.create(
      name: Faker::Educator.course,
      category: ["Math", "English", "Science", "Art", "Sports"].sample,
      date: Time.now,
      max_points: rand(60..90),
      weight: rand(10..100),
      school_class_id: school_class.id
      )
  end
  puts "Assignments added!"

  puts "Adding a grade to each assignment for each student..."
    Assignment.where(school_class_id: school_class.id).each do |assignment|
      Student.where(school_class_id: school_class.id).each do |student|
        Grade.create(
          earned_points: rand(1..assignment.max_points),
          student_id: student.id,
          assignment_id: assignment.id
          )
      end
    end
  puts "Grades added!"
end
