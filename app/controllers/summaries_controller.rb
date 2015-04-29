class SummariesController < ApplicationController
  def new
    @topic    = Topic.find(params[:topic_id])
    @post     = Post.find(params[:post_id])
    @summary  = Summary.new
  end

  def create
    @topic    = Topic.find(params[:topic_id])
    @post =  Post.find(params[:post_id])
    @summary = @post.build_summary(params.require(:summary).permit(:body))
    if @summary.save
      flash[:notice] = "Summary was created."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error creating the Summary. Please try again."
      render :new
    end
  end

  def edit
    @topic    = Topic.find(params[:topic_id])
    @post     = Post.find(params[:post_id])
    @summary  = Summary.find(params[:id])
  end

  def update
    @topic    = Topic.find(params[:topic_id])
    @post     = Post.find(params[:post_id])
    @summary  = Summary.find(params[:id])
    if @summary.update_attributes(params.require(:summary).permit(:body))
      flash[:notice] = "Summary was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the Summary. Please try again."
      render :new
    end
  end


end
