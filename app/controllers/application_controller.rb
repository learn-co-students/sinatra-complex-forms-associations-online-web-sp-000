class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get "/" do 
    "Connection Worked. Now Now follow the instructions in the document to continue."
  end 

end