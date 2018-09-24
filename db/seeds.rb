# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(
      email: 'admin@ya.ru' ,
      nickname: 'Admin',
      password: '123456',
      password_confirmation: '123456',
      first_name:'Сын маминой подруги',
      last_name:'Твоей маминой подруги',
      is_admin: true

    )


50.times do |i|
  User.create!(

      email: "test#{i}@ya.ru" ,
      nickname: "Lord#{i}",
      password: "123456",
      password_confirmation: "123456",
      first_name:"Людовик #{i}",
      last_name:"'Генрихович #{i}"
  )
end



10.times do |i|
  Category.create!(
      name: "Category- #{i}",
      type_of: [Category.type_ofs[:article], Category.type_ofs[:report]].sample
  )
end


50.times do |i|
  Article.create!(
      user: User.order('RANDOM()').last,
      title:"test title#{i}",
      ip: "127.0.0.#{i}",
      text: "Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы на русском языке, а начинающему оратору отточить навык публичных выступлений в домашних условиях. "
  )
end