require 'faker'

p = Post.find_or_create_by(title: 'Unique post2', body: "This is the body.")
c = Comment.find_or_create_by(post: p, body: "This is the comment.")

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"