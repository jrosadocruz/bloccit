require 'faker'

# Create Posts
# 50.times do
#   Post.create!(
#     title:  Faker::Lorem.sentence,
#     body:   Faker::Lorem.paragraph
#   )
# end
# posts = Post.all

# Create Comments
# 100.times do
#   Comment.create!(
#     post: posts.sample,
#     body: Faker::Lorem.paragraph
#   )
# end

# Create ads
50.times do
  Advertisement.create!(
    title:  Faker::Lorem.sentence,
    copy:   Faker::Lorem.paragraph,
    price:  Faker::Number.number(3)
  )
end
ads = Advertisement.all

puts "Seed finished"
puts "#{Advertisement.count} advertisements created"