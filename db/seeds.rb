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

4.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password!",
    password_confirmation: "password!"
    )
end

puts "Users built!"
puts "Building classes..."

i = 1
5.times do
  SchoolClass.create(
    name: Faker::StarWars.planet,
    description: Faker::StarWars.quote,
    user_id: i
    )
  i += 1
end

puts "Classes built!"
puts "Building students..."


100.times do
  Student.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    bio: Faker::HarryPotter.quote,
    birthday: Faker::Date.birthday(6, 12),
    school_class_id: (1..5).to_a.sample
    )
end

puts "Students built!"
puts "Building Assignments..."

100.times do
  Assignment.create(
    name: Faker::Educator.course,
    category: Faker::Job.field,
    date: Time.now,
    max_points: (1..50).to_a.sample,
    weight: (1..100).to_a.sample,
    school_class_id: (1..5).to_a.sample
    )
end

puts "Assignments built!"
puts "Building Grades..."

200.times do
  Grade.create(
    earned_points: 10,
    student_id: (1..100).to_a.sample,
    assignment_id: (1..100).to_a.sample
    )
end

puts "Grades built!"
