## Rails Lesson 1 Quiz - Tealeaf Academy

**1** Why do they call it a relational database?
        
**Answer:** Because a relational database is made of several tables which **relate** to each other throgh foreign and primary keys. For example, if you have two tables `users` and `posts` the `posts` table can have a column called `user_id` which **relates** to the `user` tabl's `id` column. 


**2** What is SQL?

**Answer** SQL stand for structured query language. It's a language for interacting with databases. An example of SQL is `SELECT * FROM posts WHERE user_id = '1'` . This would select all the rows from the post table where the user_id colum has a value of 1. 

**3** There are two predominant views into a relational database. What are they, and how are they different?

**Answer** The schema and data view. The schema is the structure of a database with colmn names and data types of each colmn. The data view is of the data in the tables like an excell spreadsheet. 

**4** In a table, what do we call the column that serves as the main identifier for a row of data? We're looking for the general database term, not the column name.

**Answer** The primary key

**5** What is a foreign key, and how is it used?

**Answer** A foreign key is a column that stores the id's from another table. This serves as a reference to another model. 

**6** At a high level, describe the ActiveRecord pattern. This has nothing to do with Rails, but the actual pattern that ActiveRecord uses to perform its ORM duties.

**Answer** ActiveRecord is used to access the database. Each class is related to a table in the database. Active record creates SQL for interacting with the database to perform CRUD actions. Each row of data in the tables in turned into an object by ActiveRecord.

**7** If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?

**Answer** crazy_monkeys" . You can sue the tableize method in rails console to find the table name rails expects. "CrazyMonkey".tableize => crazy_monkeys

**8** If I'm building a 1:M association between Project and Issue, what will the model associations and foreign key be?

**Answer** `has_many :issues` `belongs_to :project`  the foreign key would be `project_id`

**9** Given this code

        class Zoo < ActiveRecord::Base
            has_many :animals
        end

  * What do you expect the other model to be and what does database schema look like?
      
        class Animal
          belongs_to :zoo
        end
  
  **the database will have tables** 
  `animals` with a primary key of `id` and foreign key of `zoo_id`
  `zoos` with primary key of id

  * What are the methods that are now available to a zoo to call related to animals?
  
    * `zoo.animalls` all of the animals
    * `zoo.animal.last` the last animal in the zoo
    * `zoo.animal.find 3` this finds the animal in the zoo with an id of 3
    * there are several more possibilities 

  * How do I create an animal called "jumpster" in a zoo called "San Diego Zoo"?
  
        $ zoo = Zoo.create(name: "Metro Zoo") => sets primary key of this zoo to 1
        $ animal = Animal.create(name: "jumpster", zoo_id: 1)


**10** What is mass assignment? What's the non-mass assignment way of setting values?

**Answer**  Mass assignment lets us set multiple values to attributes with a single assignment operator

Mass assignment
        Post.create(tite: "hello!", url: "www.fake.com")
        
Non-mass assignment
        post = Post.new
        post.title = "Hello!"
        post.url = "www.fake.com"

**11** What does this code do? Animal.first

**Answer** Returns an object the first row in the animals table.

**12** If I have a table called "animals" with columns called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe". Which methods makes sure it saves to the database?

**Answer** 
        animal = Animal.create(name: "Joe") - this saves to the database instantly
        
        animal = Animal.new(name: "Joe") - this needs to be saved to the database
        animal.save - this saves the animal object to the database

**13** How does a M:M association work at the database level?

**Answer** We use a join table. Both of the primary models in the M:M have a 1:M association with the join table. By useing `has_many :through` , we are able to create an inderect M:M associatoin with the primary models

**14** What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?

**Answer**
1) habtm : has and belongs to many
2) hmt : has many through

Pros of 1) You don't need to create a seperate join model. 
Cons of 1) can't put additional attributes (columns) on association, less flexible

Pros of 2) can put additional attributes (columns) on association, more flexible
Cons of 2) has a join model

**15** Suppose we have a User model and a Group model, and we have a M:M association all set up. How do we associate the two?

**Answer** 

Use a join model and table. UserGroup and user_groups

`User` model

        class User < ActiveRecord::Base
          has_many :user_groups
          has_many :groups, through: :user_groups
        end

`UserGroup` model

        class UserGroup < ActiveRecord::Base
          belongs_to :group
          belongs_to :user
        end

`Group` model

        class Group < ActiveRecord::Base
          has_many :user_groups
          has_many :users, through: :user_groups
        end
        
        
        
        
        
        
        
        
        
        
