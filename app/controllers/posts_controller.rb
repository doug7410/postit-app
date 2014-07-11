class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :votes]
  before_action :require_creator,  only: [:edit, :update]

  def index
    @posts = Post.all.sort_by { |x| x.total_votes }.reverse

    respond_to do |format|
      format.html
      format.xml { render xml: @posts}
      format.json { render json: @posts }
    end
  end
  
  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml { render xml: @post}
    end
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

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    @object = @post

      respond_to do |format|
        format.html do  
          if @vote.valid?
            flash[:notice] = "Your vote was counted"
          else
            flash[:error] = "You can only vote on this once."
          end
          redirect_to :back
        end  
        format.js {render 'shared/vote'}
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
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end 

end
