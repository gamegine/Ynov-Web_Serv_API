# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "destroy all"

Watch.destroy_all
Movie.destroy_all
User.destroy_all

puts "create user"

userelm = User.create(email: "test@test.com",password:'123456')


puts "create movies and watches"

5.times do 
    movieelm = Movie.create({
        title: Faker::Name.name,
        user: userelm,
    })
    Watch.create({
        user: userelm,
        movie: movieelm, 
        rating: 10, 
        comment: "test"
    })
end
