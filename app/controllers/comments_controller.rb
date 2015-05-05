class CommentsController < ApplicationController
  def new
    @topic = Topic.find(params[:topic_id])
    @post  = Post.find(params[:user_id])
    @comment = @post.comments.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post  = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment saved"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving comment. Please try again."
      render :new
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end
end
