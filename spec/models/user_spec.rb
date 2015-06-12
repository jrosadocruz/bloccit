require 'rails_helper'

describe User do
  include TestFactories

  describe "#favorites(post)" do
    before do
      @post       = associated_post
      @post_other = associated_post
      @user       = authenticated_user
      favorite   = @user.favorites.create(post: @post)
    end

    it "returns 'nil' if the user has not favorited the post" do
      expect( @user.favorited(@post_other) ).to eq(nil)
    end

    it "returns the appropiate favorite if it exists" do
      expect( @user.favorites.count ).to eq(1)
    end
  end

  describe ".top_rated" do

    before do
      @user1 = create(:user)
      post = create(:post, user: @user1)
      create(:comment, user: @user1, post: post)

      @user2 = create(:user)
      post = create(:post, user: @user2)
      2.times { create(:comment, user: @user2, post: post) }
    end

    it "returns users ordered by comments + posts" do
      expect( User.top_rated ).to eq([@user2, @user1])
    end

    it "stores a `posts_count` on user" do
      users = User.top_rated
      expect( users.first.posts_count ).to eq(1)
    end

    it "stores a `comments_count` on user" do
      users = User.top_rated
      expect( users.first.comments_count ).to eq(2)
    end

  end

  describe "user_with_post_and_comment" do
    before do
      @user3 = create(:user_with_post_and_comment)
    end

    it "returns user's post" do
      expect( @user3.posts.count ).to eq(1)
    end

    it "returns user's post comments" do
      expect( @user3.posts.first.comments.count ).to eq(1)
    end

  end

end