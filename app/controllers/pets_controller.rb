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
    #binding.pry
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
    @pet = Pet.create(params[:pet])
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save # to save the association with it's owner
    end
    #binding.pry  
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    # if !params[:pet].keys.include?("owner_id")
    #   @pet.owner = params[:owner][:name]
    # end
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end
end