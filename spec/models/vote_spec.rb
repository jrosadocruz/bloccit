require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        invalid_vote = Vote.new({value: 2})
        expect(invalid_vote.valid?).to eq(false)
      end

      it "only allows 1" do
        valid_vote = Vote.new({value: 1})
        expect(valid_vote.valid?).to eq(true)
      end

      it "only allows -1" do
        valid_vote = Vote.new({value: -1})
        expect(valid_vote.valid?).to eq(true)
      end

    end
  end

  describe 'after_save' do
    it "calls 'Post#update_rank' after save" do
      post = associated_post
      vote = Vote.new(value: 1, post: post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end

end

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