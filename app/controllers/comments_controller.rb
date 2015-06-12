class CommentsController < ApplicationController
  def new
    @post  = @topic.posts.find(params[:user_id])
    @comment = @post.comments.new
  end

  def create
    @post  = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user = current_user
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment saved"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving comment. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
      # redirect_to [@post.topic, @post]
    else
      flash[:error] = "Comment could't be deleted. Try again."
      # redirect_to [@post.topic, @post]
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end
end
