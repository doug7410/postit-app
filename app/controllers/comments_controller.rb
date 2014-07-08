class CommentsController < ApplicationController

  before_action :require_user
  before_action :find_post

  def create
    
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = current_user
    @comment.post_id = @post.id

    if @comment.save
      flash[:notice] = "Your comment was created."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment =  Comment.find(params[:id])
    vote = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
    @object = comment
    respond_to do |format|
      
      if vote.valid?
        format.js { render 'posts/vote' }
         
      else
        @error = true
        format.js { render 'posts/vote' }
      end

    end

    #if vote.valid?
    #  flash[:notice] = "Your vote was counted"
    #else
    #    flash[:error] = "You can only vote on this once."
    #end

    #redirect_to :back

  end

  def find_post
    @post = Post.find_by(slug: params[:post_id])
  end

end