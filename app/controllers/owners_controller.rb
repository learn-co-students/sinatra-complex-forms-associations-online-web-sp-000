class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  #Built a controller action that uses mass assignment to create a new owner and associate it to any existing pets that the user selected via checkboxes.
  #Added to that controller action code that checks to see if a user did in fact fill out the form field to name and create a new pet.
  # If so, our code will create that new pet and add it to the newly-created owner's collection of pets.#
  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty? #if statement to check whether or not the value of params["pet"]["name"] is an empty string.
      #creating our new pet we'll have to grab the new pet's name from params["pet"]["name"], 
      #use it to create a new pet, and add the new pet to our new owner's collection of pets POGLEDAJ new.erb
      @owner.pets << Pet.create(name: params["pet"]["name"])
      # When using the shovel operator, ActiveRecord instantly fires update SQL
      # without waiting for the save or update call on the parent object,
      # unless the parent object is a new record.
    end
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    ####### bug fix #The bug fix is required so that it's possible to remove ALL previous pets from owner.
    if !params[:owner].keys.include?("pet_ids")
        params[:owner]["pet_ids"] = []
    end
    #######
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect "/owners/#{@owner.id}"
  end
end