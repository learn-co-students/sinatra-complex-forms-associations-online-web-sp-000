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

    existing_owner = Owner.exists?(name: params["owner_name"])

    if !params["owner_name"].empty? && !existing_owner
      pet_owner = Owner.create(name: params["owner_name"])
    else
      pet_owner = Owner.find(params["owner_id"])
    end

    @pet = Pet.create(name: params["pet_name"], owner_id: params["owner_id"])
    @pet.owner = pet_owner

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do

    @pet = Pet.find(params[:id])
    @owner = @pet.owner

    erb :'/pets/edit'
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    @pet = Pet.find(params[:id])
    @pet.update(params["owner_name"])

    redirect to "pets/#{@pet.id}"
  end
end
