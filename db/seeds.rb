# ruby encoding: utf-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'securerandom'

u_arr = [
    {id: 1, email: 'shiegin@gmail.com', fname: 'Vitaliy', lname: 'Shiegin', password: 'qqqqqqqq'},
#    {id: 10, email: 'qqq0@qqq.com', fname: 'Ivan', lname: 'Ivanov'},
    ]
(10..30).each do |n|
    u_arr.push id: n, email: "qqq#{n}@qqq.com", fname: "Ivan #{n}", lname: "Ivanov #{n}"
end

User.destroy_all

u_arr.each do |r|
    r.merge! userpin: r[:id]
    r.merge! password: SecureRandom.hex unless r[:password]
    u = User.create r
    u.save!
    puts u.fname
end

