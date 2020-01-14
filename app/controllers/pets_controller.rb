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
    @pet = Pet.create
    @pet.name = params[:pet_name]
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find_by(params[:pet][:owner_id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    @pet = Pet.find(params[:id])
    if !params["pet_name"].empty?
      @pet.name = params["pet_name"]
    end

    if !params["owner"]["name"].empty?
      owner = Owner.find_by(name: params[:owner][:name])
      if owner == nil
        owner = Owner.create(name: params["owner"]["name"])
        @pet.owner = owner
      else
        @pet.owner = owner
      end
    else
      owner = Owner.find_by(id: params[:pet][:owner_id])
      @pet.owner = owner
      #binding.pry
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(params[:id])
    @owner = @pet.owner
    erb :'/pets/edit'
  end

end
