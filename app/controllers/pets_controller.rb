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
    @pet = Pet.create(params["pet"])
    if params["pet"][:owner_id]
      @pet.owner = Owner.find(params["pet"][:owner_id])[0]
      @pet.save
    elsif !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    # binding.pry
    # if !params[:owner].keys.include?("pet_ids")
    #   params[:owner]["pet_ids"] = []
    # end

    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    # binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    elsif params["owner_id"]
      # binding.pry
      @pet.owner = Owner.find_by(id: params["owner_id"])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end