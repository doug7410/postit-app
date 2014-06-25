class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post_id = params[:post_id]
    @comment.creator = User.find(1)
    @post = Post.find(params[:post_id])

    if @comment.save
      flash[:notice] = "Your comment was created"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end