class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)
    authorize favorite
    if favorite.save
      flash[:notice] = "Post was favorited."
      redirect_to [post.topic, post]
    else
      flash[:error] = "There was an error favoriting the post. Please try again."
      rend
    end

  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by_post_id(params[:post_id])
    authorize favorite
    if favorite.destroy
      flash[:notice] = "Post was unfavorited"
      redirect_to [post.topic, post]
    else
      flash[:error] = "There was an error un-favoriting the post"
      render :show
    end
  end

end
