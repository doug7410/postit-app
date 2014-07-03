class CommentsController < ApplicationController

  before_action :require_user, except: [:vote]
  before_action :find_post

  def create
    
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = current_user
    @comment.post_id = params[:post_id]
    
    if @comment.save
      flash[:notice] = "Your comment was created."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @vote = Vote.create(voteable: @post.comments.find(params[:id]), creator: current_user, vote: params[:vote])

    if @vote.valid?
      @vote.save
      flash[:notice] = "Your vote was counted"
    else
      if logged_in?
        flash[:error] = "You can only vote on this once."
      else
        flash[:error] = "Please log in to vote."
      end
    end

    redirect_to :back

  end

  def find_post
    @post = Post.find(params[:post_id])
  end

end