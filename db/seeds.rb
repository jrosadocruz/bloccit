require 'faker'

post = Post.find_by(title: 'Unique post2')

if !post
  Post.create!(
    title: "Unique post2",
    body: Faker::Lorem.paragraph
  )
end

post = Post.find_by(title: 'Unique post2')

if post.comments.length < 1
  Comment.create!(
    post: post,
    body: Faker::Lorem.paragraph
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"