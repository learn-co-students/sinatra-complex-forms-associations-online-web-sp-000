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
    @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet][:name]

    if params[:owner][:name].empty?
      @owner = Owner.find(params[:pet][:owner_id])
      @pet.owner = @owner
    else
       @owner = Owner.create(name: params[:owner][:name])
       @pet.owner = @owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end