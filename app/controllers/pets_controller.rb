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
    @pet = Pet.new(name: params["pet"]["name"])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
    else
      owner = Owner.find(params["pet"]["owner_ids"]).first
    end
    
    @pet.owner = owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    # binding.pry
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] =[]
    end

    @pet= Pet.find(params[:id])
    @pet.update(params["pet"])

    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
    else
      owner = Owner.find(params["pet"]["owner_id"])
    end
    @pet.owner = owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end