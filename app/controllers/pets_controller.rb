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
    # @pet = Pet.create(name: params["pet_name"], owner: Owner.find(params["owner_id"]))
    if !params["owner_name"].empty?
      @pet = Pet.create(name: params["pet_name"], owner: Owner.create(name: params["owner_name"]))
       # @pet.owner = Owner.create(name: params["owner_name"])
    else
      @pet = Pet.create(name: params["pet_name"], owner: Owner.find(params["owner_id"]))
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get "/pets/:id/edit" do
    @owners = Owner.all
    @pet = Pet.find(params[:id])

    erb :"/pets/edit"
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if !params["owner_name"].empty?
      @pet.update(name: params["pet_name"], owner: Owner.create(name: params["owner_name"]))
    else
      @pet.update(name: params["pet_name"], owner: Owner.find(params["owner_id"]))
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end
end