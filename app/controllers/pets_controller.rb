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

    @pet = Pet.create(name: params["pet_name"], owner_id: params["owner_id"])

    existing_owner = Owner.exists?(name: params["owner_name"])

    if !params["owner_name"].empty? || !existing_owner
      @pet.owner = Owner.create(name: params["owner_name"])
    # else
    #   @pet.owner = Owner.find_by(id: params["owner_id"])
    #   binding.pry
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
