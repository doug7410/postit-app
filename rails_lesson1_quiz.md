## Rails Lesson 1 Quiz - Tealeaf Academy

**1** Why do they call it a relational database?
        
**Answer:** Because a relational database is made of several tables which **relate** to each other throgh foreign and primary keys. For example, if you have two tables `users` and `posts` the `posts` table can have a column called `user_id` which **relates** to the `user` tabl's `id` column. 


**2** What is SQL?

**Answer** SQL stand for structured query language. It's a language for interacting with databases. An example of SQL is `SELECT * FROM posts WHERE user_id = '1'` . This would select all the rows from the post table where the user_id colum has a value of 1. 

**3** There are two predominant views into a relational database. What are they, and how are they different?

**Answer** The schema and data view. The schema is the structure of a database. The tables, the and the attributes of the tables. The data view is of the data in the tables. 

**4** In a table, what do we call the column that serves as the main identifier for a row of data? We're looking for the general database term, not the column name.

**Answer** The primary key

**5** What is a foreign key, and how is it used?

**Answer** A foreign key is a column that stores the id's from another table. This serves as areference to a row in another table.

**6** At a high level, describe the ActiveRecord pattern. This has nothing to do with Rails, but the actual pattern that ActiveRecord uses to perform its ORM duties.

**Answer** 

**7** If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?

**Answer** crazy_monkeys"

**8** If I'm building a 1:M association between Project and Issue, what will the model associations and foreign key be?

**Answer** `has_many :issues` `belongs_to :project`  the foreign key would be `project_id`

**9** Given this code

        class Zoo < ActiveRecord::Base
            has_many :animals
        end

  * What do you expect the other model to be and what does database schema look like?
  * What are the methods that are now available to a zoo to call related to animals?
  * How do I create an animal called "jumpster" in a zoo called "San Diego Zoo"?

**Answer** 

**10** What is mass assignment? What's the non-mass assignment way of setting values?

**Answer** Mass assignment is when you pass values directly to a class and creates a new object. You can set object values by passing them directly to the object. This is not mass assignment. 

**11** What does this code do? Animal.first

**Answer** Selects the first Animal object from the database in the Animal model

**12** If I have a table called "animals" with columns called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe". Which methods makes sure it saves to the database?

**Answer** Animal.create(name: "Joe")

**13** How does a M:M association work at the database level?

**Answer** There are two table that can have many instances of each other. For example: a student can have many classes, and a class can have many students.

**14** What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?

**Answer**
1) habtm : has and belongs to many
2) hmt : has many through

Pros of 1) You don't need to create a seperate join model. 
Cons of 1) can't put additional attributes (columns) on association

Pros of 2) can put additional attributes (columns) on association
Cons of 2) has a join model

**15** Suppose we have a User model and a Group model, and we have a M:M association all set up. How do we associate the two?

**Answer** `user.groups` `group.users`
