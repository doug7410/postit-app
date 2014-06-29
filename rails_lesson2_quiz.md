## Rails Lesson 2 Quiz - Tealeaf Academy

**1:** Name all the 7 (or 8) routes exposed by the resources keyword in the routes.rb file. Also name the 4 named routes, and how the request is routed to the controller/action.

Answer: index, create, new, edit, show, update, delete

**2:** for the posts resource the routes would look like this
        
        posts GET   /posts           posts#index
              POST  / posts          posts#create
     new_post GET   / posts/new      posts#new
    edit_post GET   / posts/:id/edit posts#edit
         post GET   / posts/:id      posts#show
          PATCH,PUT / posts/:id      posts#update
          DELETE    / posts/:id      posts#destroy



**3:** What is REST and how does it relate to the resources routes?

Answer: REpresentaional State Transfer(REST). It uses a stateless communication protocol, like HTTP. RESTful applications use HTTP to perform CRUD operations(Create,Retrieve,Update,Delete) . When we use resources in our rails app, we are mapping the browsers request(GET, POST, etc..) to the controller actions of our app, so the app will work smothly with the browser through HTTP request. So in other words, `resources` help a rails app to perform RESTfully by creating a smooth workflow between the browser, HTTP request, and the application.

**4:** What's the major difference between model backed and non-model backed form helpers?

Answer: Model backed form helpers use an object to create the form action, and method. They also know if the object is new or existing and use that information to decide where the form submits to. They also pre-populate the form if there is a validation error, or if the object exist. Non model backed form helpers only create HTML. You have to account for all the different edge cases manual.

**5:** How does form_for know how to build the <form> element?

Answer: By looking at the object passed in and whether it's new or already exists.
By convention, form_for creates a form based on a specific model object. We are able to create, edit, and update that object's attributes.
A form can be created by passing form_for a string or symbol relating to the object we want to deal with.

      <%= form_for @posts do |f| %>
      <%= f.label :title %>
      <%= f.text_field :title %>
      <% end %>

**6:** What's the general pattern we use in the actions that handle submission of model-backed forms (ie, the create and update actions)?

Answer: Use of params submitted by the form. Build the new object from them. Attempt to save the new object into the database. If it's saved, redirect to somewhere, else re-render the page with the form on it.
        
        def create
        @post = Post.new(params.require(:post).permit(:url, :title, :description))

          if @post.save
              flash[:notice] = "Your post was saved."
              redirect_to posts_path
          else
              render :new
          end
        end

        def update
          @post = Post.find(params[:id])

          if @post.update(params.require(:post).permit(:url, :title, :description))
              flash[:notice] = "Your post was updated."
              redirect_to post_path(@post)
          else
              render :edit
          end
        end

**7:** How exactly do Rails validations get triggered? Where are the errors saved? How do we show the validation messages on the user interface?

Answer: Conditions are set in the model. When a new object is saved, if any of those condition are not met an error object is created on the object being saved. You can access the errors like this `object.errors.full_messages.each`.

      <% if obj.errors.any? %>
      <div class="row">
          <div class="alert alert-error span8">
          <h5>Please fix the following errors:</h5>
          <ul>
          <% obj.errors.full_messages.each do |msg| %>
              <li><%= msg %></li>
          <% end %>
          </ul>
          </div>
      </div>
      <% end %>

**8:** What are Rails helpers?

Answer: Helpers are methods saved in 'app/helpers' directory to extract small bits of logic. They are mostly used for formatting. 

**9:** What are Rails partials?
Answer: Partials are used to extract chunks of HTML and logic and can be reused in all the view templates. Partial files are named with an underscore at the beginning like so - _errors.html.erb

**10:** When do we use partials vs helpers?

Answer: We use helpers for small bits of code that contain logic and formatting. Partials are used for larger chunks of HTML. Helpers should not contain HTML. 

(From Answers: A partial is a view fragment with HTML code that is usually shared and used multiple times in view files. It should consists of code that is for presentation purposes only.
On the other hand, while helpers also reduce code duplications, they are meant to be used when there is some logic to be processed within a view. 
This will eliminate the views to be consumed by logic, and instead, the views can remain "pure" for presentation usages.)

**11:** When do we use non-model backed forms?

We use non-model backed forms in situations where the form in not associated with a model. The form is just HTML with no "rails magic".