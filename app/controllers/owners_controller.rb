class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    #create owner 
    @owner = Owner.create(params["owner"])
    #if pet name is given, create pet
    if !params["pet"]["name"].empty?
      @pet = Pet.create(name: params["pet"]["name"])
      #add new pet to owner's pets
      @owner.pets << @pet 
    end
    redirect "owners/#{@owner.id}"
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
    #after update button is clicked, params is passed
     
  # => {"_method"=>"patch", 
  #     "owner"=>{"name"=>"Carla Gremillion", "pet_ids"=>["1"]}
  #     "pet"=>{"name"=>""}, "id"=>"1"

  #if unchecking all pets, clear params[:owner]["pet_ids"]  
     if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end

     @owner = Owner.find(params[:id])
    @owner.update(params["owner"])

    #if adding a new pet (pet["name"] not empty)
    if !params["pet"]["name"].empty?
      @pet = Pet.create(name: params["pet"]["name"])
      @owner.pets << @pet 
    end
    redirect "owners/#{@owner.id}"
  end


end