class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_admin, 
                :require_user, :is_post_creator_or_admin?,
                :vote_for

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] && User.any?
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

  def require_admin
    access_denied unless logged_in? && current_user.admin?
  end     

  def access_denied
    flash[:error] = "You do not have permission to do that."
    redirect_to root_path
  end

  def is_post_creator_or_admin?
    @post.creator == current_user || current_user.role == 'admin'
  end

  def vote_for(object)
    if object.class.name == "Post"
      "post"
    elsif object.class.name == "Comment"
      "comment"
    end
  end

end
 