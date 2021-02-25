# the order in which you define your routes in a controller matters
# So, if we define the get '/articles/:id' route before the 
# get '/articles/new' route, Sinatra would feed all requests for /articles/new to the /articles/:id route
# and we should see an error telling us that our app is unable to find an Article instance with an id of "new".
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end