# the order in which you define your routes in a controller matters
# So, if we define the get '/articles/:id' route before the 
# get '/articles/new' route, Sinatra would feed all requests for /articles/new to the /articles/:id route
# and we should see an error telling us that our app is unable to find an Article instance with an id of "new".
class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all 
    erb :'/owners/new'
  end

  post '/owners' do # since we set up our associations such that an owner has many pets, ActiveRecord is smart enough to take that additional key of "pets_ids" (pointing to an array of numbers), find the pets that have those IDs, and associate them to the given owner using mass assignment here
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"]) # we don't have to save here, because we're adding something to an existing array
    end
    # binding.pry
  redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find_by_id(params[:id])
    @pets= Pet.all
    #binding.pry 
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    #binding.pry
    if !params[:owner].keys.include?("pet_ids")
    params[:owner]["pet_ids"] = []
    end
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
      @owner.save
    end
    redirect "owners/#{@owner.id}"
  end
end