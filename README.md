# README

Basic blog demo with blog posts and comments.
Home page indexes all posts and has links to them, as well as a button to create a new post.

To run the application simply run rails server `rails s` and navigate to `localhost:3000`

# Post

This object has title and content, it can be editted or deleted. Each post page include the list of comments

# Comment

Comments belong to posts. They can be created and/or deleted. When a post is deleted, all its comments will be deleted as well. 
