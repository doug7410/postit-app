

####1) What's the difference between rendering and redirecting? What's the impact with regards to instance variables, view templates?

Answer: Rendering will render a view template from within the current controller action. During a render the view template has access to any instance variables present in that controller action. Redirect creates a brand new request to a new controller and action. Instance variables from the action making the request are not accessible.

####2) If I need to display a message on the view template, and I'm redirecting, what's the easiest way to accomplish this?

Answer: Add a message to the flash[:notice] or flash[:error] session variable like this before the redirect.
      
      flash[:notice] = "Here is your message!"

####3) If I need to display a message on the view template, and I'm rendering, what's the easiest way to accomplish this?

Answer: Add to the error messages on the object being displayed in the view template. Example
      
      if @post.save
        #do a redirect here
      else
        render new_post_path
      end

In this example, if @post.save doesn't work there will be errors added to the @post object and when `new_post_path` is rendered, the view will be able to access them on the @post object like this
      
      <% @post.errors.full_messages.each do |msg| %>
      <li><%= msg %> </li>
      <% end %>

####4) Explain how we should save passwords to the database.

Answer: Passwords are saved using the `has_secure_password` method

* the `has_secure_password` method is added to the model (User) 
* the users table needs a column called 'password_digest'. The column need to be of type string. 
* the gem 'bcrypt-ruby' must be installed and added to the Gemfile
* when a password is saved you use the `password` setter method. When creating a new user, mass assignment might look something like this
      
        User.new(username: "Steve0", password: "abc123")

####5) What should we do if we have a method that is used in both controllers and views?

Answer: Add it the the ApplicationController class

####6) What is memoization? How is it a performance optimization?

Memoization is done like this:
      
      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id] && User.any?
      end

Now when the current_user method is called from anywhere in the application it will first check if `@current_user` exist, if it doesn't , the code in the right side of the `||=` will execute and the `@current_user` variable will be set to it's value. The next time `current_user` is called `@current_user` will exist, and the code on the right will not need to run, saving the server the resources that would of been used in performing that operation. 

####7) If we want to prevent unauthenticated users from creating a new comment on a post, what should we do?

There are two things we can do. 
* First, hide the new comment form in the view template if the user is not logged in. You can do this by creating a method that returns a boolean based on whether the the pserson is logged in. The view template can then show or hide the new comment form based on the result of this method.
* The second thing is to create a before filter in the controller. Here is an example
      
        class CommentsController < ApplicationController

          before_action :require_user

          def create
            @post = Post.find(params[:post_id])
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
        end

In this example, `:require_user` is a method set in the `ApplicationController` class. `before_action` makes the `require_user` method run before all other code in any of the actions in the `CommentsController` That `require_user` method looks like this:
      
      def require_user
        if !logged_in?
          flash[:error] = "You must be logged in to do that."
          redirect_to root_path
        end
      end

So in this example.if the user is not logged in they end up being redirected to the `root_path`, and flash[:error] is set to "You must be logged in to do that."


####8) Suppose we have the following table for tracking "likes" in our application. How can we make this table polymorphic? Note that the "user_id" foreign key is tracking who created the like.

<table>
<tr>
<th>id</th><th>user_id</th><th>photo_id</th><th>video_id</th><th>post_id</th>   
</tr>
<tr>
<td>1</td><td>4</td><td> </td><td>12</td><td> </td>   
</tr>
<tr>
<td>7</td><td>4</td><td> </td><td> </td><td>3</td>   
</tr>
<tr>
<td>2</td><td>4</td><td>6</td><td> </td><td> </td>   
</tr>
</table>

Answer:
<table>
<tr>
<th>id</th><th>user_id</th><th>likeable_type</th><th>likeable_id</th>   
</tr>
<tr>
<td>1</td><td>4</td><td>Video</td><td>12</td>   
</tr>
<tr>
<td>7</td><td>4</td><td>Post</td><td>3</td>   
</tr>
<tr>
<td>2</td><td>4</td><td>Photo</td><td>6</td>   
</tr>
</table>



####9) How do we set up polymorphic associations at the model layer? Give example for the polymorphic model (eg, Vote) as well as an example parent model (the model on the 1 side, eg, Post).

Answer:
      
      class Vote < ActiveRecord::Base
        belongs_to :voteable, polymorphic: true
      end

      class Post < ActiveRecord::Base
        has_many :votes, as: :voteable
      end

####10) What is an ERD diagram, and why do we need it?

Answer: ERD stands for Entity Relationship Diagram. It's a blueprint of all the models and their relationships to each other. Each model is represented by a box containing the table name, attributes, and foreign keys. It's important to have this before you start working on an app so you have a point of reference when creating tables and models.
