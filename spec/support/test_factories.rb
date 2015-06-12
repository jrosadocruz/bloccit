module TestFactories

  def associated_post(options={})
    post_options = {
      title: 'Post title',
      body: 'Post bodies must be pretty long.',
      topic: Topic.create(name: 'Topic name'),
      user: authenticated_user
    }.merge(options)
    Post.create(post_options)
  end

  def authenticated_user(options={})
    user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end

end

FactoryGirl.define do
  factory :user do
    email 'jose@rosa.do'
    password 'holamundo1'

    # if needed
    # is_active true
  end
end

RSpec.configure do |config|
  config.after :each do
    Warden.test_reset!
  end
end