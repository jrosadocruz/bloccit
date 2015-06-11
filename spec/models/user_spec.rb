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

end