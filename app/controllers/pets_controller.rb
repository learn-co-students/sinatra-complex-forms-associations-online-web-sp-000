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
    if params["owner"]["name"] != ""
      @owner = Owner.create(params["owner"])
    else
      @owner = Owner.find(params["pet"]["owner_id"])
    end
    @pet = Pet.create(name: params["pet"]["name"], owner_id: @owner.id)
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    #binding.pry
    @pet = Pet.find(params[:id])
    if params["owner"]["name"] != ""
      @owner = Owner.create(params["owner"])
      params["pet"]["owner_id"] = @owner.id
    end
    @pet.update(params["pet"])
    
    redirect to "pets/#{@pet.id}"
  end
end