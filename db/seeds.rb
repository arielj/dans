# typed: strict
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[[:name, 'Instituto Fulanito'], [:opening_time, '09:00'], [:closing_time, '22:00'],
 [:recharge_after_day, '10'], [:recharge_value, '10%'], [:language, 'es'],
 [:month_recharge_value, '25%'], [:family_discount, '0']].each do |k, v|
  Setting.set k, v
end

Setting.set_hours_fees 1, [100, 90]
Setting.set_hours_fees 1.5, [150, 135]
Setting.set_hours_fees 2, [200, 180]
Setting.set_hours_fees 2.5, [250, 225]
Setting.set_hours_fees 3, [300, 270]
Setting.set_hours_fees 3.5, [350, 325]
Setting.set_hours_fees 4, [400, 360]
Setting.set_hours_fees 4.5, [450, 405]
Setting.set_hours_fees 5, [500, 450]
Setting.set_hours_fees 5.5, [550, 495]
Setting.set_hours_fees 6, [600, 550]
Setting.set_hours_fees 6.5, [650, 595]
Setting.set_hours_fees 7, [700, 630]
Setting.set_hours_fees 7.5, [750, 685]
Setting.set_hours_fees 8, [800, 720]
Setting.set_hours_fees 8.5, [850, 765]
Setting.set_hours_fees 9, [900, 810]
Setting.set_hours_fees 9.5, [950, 855]
Setting.set_hours_fees 10, [1000, 900]
Setting.set_hours_fees 10.5, [1050, 995]

Admin.create!(
  email: 'admin@test.com',
  password: 'admin123',
  password_confirmation: 'admin123',
  role: :admin
)

30.times do
  name = Faker::Name.first_name
  Person.create!(
    name: name,
    lastname: Faker::Name.last_name,
    dni: Faker::IDNumber.brazilian_id,
    birthday: Faker::Date.birthday(min_age: 4, max_age: 18),
    email: Faker::Internet.safe_email(name: name),
    gender: :female
  )
end

5.times do
  name = Faker::Name.first_name
  Person.create!(
    name: name,
    lastname: Faker::Name.last_name,
    dni: Faker::IDNumber.brazilian_id,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 50),
    email: Faker::Internet.safe_email(name: name),
    gender: :female,
    is_teacher: true
  )
end

2.times do |x|
  Room.create!(
    name: "Room #{x}"
  )
end

rooms = Room.all.to_a
Klass.create!(
  name: Faker::Music.genre,
  status: :active,
  schedules: [
    Schedule.new(from_time: 1800, to_time: 1900, day: :monday, room: rooms[0]),
    Schedule.new(from_time: 1800, to_time: 1900, day: :wednesday, room: rooms[0]),
    Schedule.new(from_time: 1800, to_time: 1900, day: :friday, room: rooms[0])
  ]
)

Klass.create!(
  name: Faker::Music.genre,
  status: :active,
  schedules: [
    Schedule.new(from_time: 1900, to_time: 2030, day: :monday, room: rooms[0]),
    Schedule.new(from_time: 1900, to_time: 2030, day: :wednesday, room: rooms[0]),
    Schedule.new(from_time: 1900, to_time: 2030, day: :friday, room: rooms[0])
  ]
)

Klass.create!(
  name: Faker::Music.genre,
  status: :active,
  schedules: [
    Schedule.new(from_time: 1800, to_time: 1900, day: :monday, room: rooms[1]),
    Schedule.new(from_time: 1900, to_time: 2100, day: :friday, room: rooms[1])
  ]
)
