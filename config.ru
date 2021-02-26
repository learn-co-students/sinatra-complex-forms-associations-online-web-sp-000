#3. Create a 'config.ru' file to be an entry point for the app. So we will have to put the following code in that file
require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# auto-add controllers
use Rack::MethodOverride
Dir[File.join(File.dirname(__FILE__), "app/controllers", "*.rb")].collect {|file| File.basename(file).split(".")[0] }.reject {|file| file == "application_controller" }.each do |file|
  string_class_name = file.split('_').collect { |w| w.capitalize }.join
  class_name = Object.const_get(string_class_name)
  use class_name
end
run ApplicationController

# The purpose of this file is to detail to Rack the environment requirements of the application and start the application. 
# generally we load the Sinatra library on the first line
# The second line requires our application file
# the last line uses run to start the application represented by the ruby class Application.
# when 'shotgun' or 'rackup' command is run, this file is where it looks for as an entry point.