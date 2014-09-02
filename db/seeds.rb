require 'faker'
User.delete_all
Post.delete_all
Comment.delete_all

##USER
20.times do
  User.create!(
      username: Faker::Name.name,
      password: Faker::Address.city,
      email: Faker::Internet.email
  )
end
##POST
10.times do |t|
  Post.create!(
      title: "#{Faker::Name.name}",
      body: Faker::Lorem.paragraph,
      user_id: User.last
  )
end
##COMMENT
10.times do
  Comment.create!(
      body: Faker::Lorem.paragraph,
      post_id: Post.first,
      user_id: User.last
  )
end
##COMMENT
10.times do
  Comment.create!(
      body: Faker::Lorem.paragraph,
      post_id: Post.last,
      user_id: User.first
  )
end

##Tag

10.times do
  Tag.create!(
      name: Faker::Name.name
  )
end

