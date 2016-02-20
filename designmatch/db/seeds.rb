# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
users = User.order(:created_at).take(6)
12.times do
  name = Faker::Lorem.sentence(5)
  description = Faker::Lorem.sentence(50)
  value = Faker::Number.positive
  users.each { |user| user.proyects.create!(name: name, description: description, value: value) }
end

#proyects = Proyect.order(:created_at).take(6)
#5.times do
#  email2    =   Faker::Internet.email
#  firstName =   Faker::Name.first_name
#  lastName  =   Faker::Name.last_name
#  offer = Faker::Number.positive
#  proyects.each { |proyect| proyect.designs.create!(email: email2, firstName: firstName, lastName: lastName, pictureOriginal: pictureOriginal, offer: offer) }
#end