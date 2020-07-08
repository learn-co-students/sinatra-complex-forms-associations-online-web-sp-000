class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

#In order to dynamically generate these checkboxes, we need to load up all of the pets from the database. Then, we can iterate over them in our owners/new.erb
#Use ERB to get all of the pets with Pet.all.
#Iterate over collection of Pet objects and generate a checkbox for each pet. (in new.erb)
#value of the checkbox = pet ID. When checkbox is selected, pet id/value is what isi sent to the params hash.
  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

#action that creates one owner
#responds to a POST request and creates a new owner based on the params from the form
#if the params pet/name are not empty, add the new pet name and save it
#redirects to the shows page
  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect "owners/#{@owner.id}"
  end

#edit action that displays the edit form based on the url
#loads the edit form in the browser
  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

#show action that displays one owner based on the ID in the url
#uses a DYNAMIC URL, can access the ID of the owner of the pet in the view through the params hash
  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

#controller action that checks to see if a user filled out the form field to name and
#create a pet. code will create that new pet and add it into our new created collection of pets 
  post '/owners/:id' do
      @owner = Owner.find_by_id(params[:id])
      @owner.update(params[:owner])
      if !params[:pet][:name].empty?
        @owner.pets << Pet.create(name: params[:pet][:name])
      end
      @owner.save
      redirect "owners/#{@owner.id}"
    end
  end
