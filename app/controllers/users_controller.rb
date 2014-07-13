class UsersController < ApplicationController

  before_action :find_user, only: [:edit, :update, :show]
  before_action :require_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You were registered."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update       
    @user.old_password = params[:old_password]

    if @user.update(user_params) 
      flash[:notice] = "Your profile was successfully updated."
      redirect_to user_path(@user)
    else
      render 'edit'
    end  
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :time_zone, :phone)
  end
 
  def find_user
    @user = User.find_by(slug: params[:id])
  end

  def require_user
    if current_user != @user
      flash[:error] = "you're not allowed to do that"
      redirect_to root_path
    end
  end


end