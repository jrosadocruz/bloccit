class CommentsController < ApplicationController
  def new
    @topic = Topic.find(params[:topic_id])
    @post  = @topic.posts.find(params[:user_id])
    @comment = @post.comments.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post  = @topic.posts.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user = current_user
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment saved"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving comment. Please try again."
      redirect_to [@topic, @post]
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end
end
