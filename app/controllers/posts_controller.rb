class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all
  end
  
  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create

    @post = Post.new(post_params)
    @categories = Category.all
    @post.creator = current_user
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render 'new'
    end

  end

  def edit
    @categories = Category.all
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "The post was successfully updated"
      redirect_to post_path(@post)
    else
      render 'edit'
    end

  end

  #def destroy
  #  @post = Post.find(params[:id])
  #  @post.destroy
  #  redirect_to posts_path
  #end

  private
    
  def post_params  
    params.require(:post).permit(:title, :description, :url, category_ids: [])
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
