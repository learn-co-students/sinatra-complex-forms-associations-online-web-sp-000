class PetsController < ApplicationController

#index action to display all the pets
#allows the view to access all of the pets in the database through instance variable pets
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

#new action to display create owner form
#GET request to load the form to create a new owner of a pet
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

#create action that creates one pet
#responds to a POST request and creates a new pet based on the params from the form
#once an item is created, action redirects to the show page
#if the field is not empty, we will create and save a new owner/pet by name/id
  post '/pets' do
  @pet = Pet.create(params[:pet])
  if !params[:owner][:name].empty?
  @pet.owner = Owner.create(name: params[:owner][:name])
  else
  @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
  end
    @pet.save
  redirect to "pets/#{@pet.id}"
    end

#show action that displays one pet based on the ID in the url
#usees a dynamic URL. can access the ID of the pet in the view through the params hash.
    get '/pets/:id' do
      @pet = Pet.find(params[:id])
      erb :'/pets/show'
    end

#edit action that displays the edit form based on the ID in the URL
#loads the edit form in the browser
    get '/pets/:id/edit' do
      @pet = Pet.find_by_id(params[:id])
      @owners = Owner.all
      erb :'/pets/edit'
    end

#controller action that checks to see if a user filled out the form field to name and
#create a pet. code will create that new pet and add it into our new created collection of pets
    post '/pets/:id' do
      @pet = Pet.find(params[:id])
      @pet.update(params["pet"])
      if !params["owner"]["name"].empty?
        @pet.owner = Owner.create(name: params["owner"]["name"])
      end
      @pet.save
      redirect to "pets/#{@pet.id}"
    end
  end
