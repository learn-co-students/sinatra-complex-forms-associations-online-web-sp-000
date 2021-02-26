#2. After the database connection, we have to create in the root directory a file called 'app.rb', that's in which we create a class called 'Application' 
# and make it inherit from 'Sinatra::Base', so that all instances of 'Application' can use all Sinatra features.
#5. create the routes/actions that will distinguish different requests to fire a specific block of code
# where it will use the logic of 'models'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
end