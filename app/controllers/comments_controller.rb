class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = User.find(1)
    @comment.post_id = params[:post_id]
    

    if @comment.save
      flash[:notice] = "Your comment was created."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end