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
    @pet = Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = @owner
      @pet.save
    else 
      @owner = Owner.find(params[:pet][:owner_id]).first
      @pet.owner = @owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end


  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = @owner
      @pet.save
    else 
      @owner = Owner.find(params[:pet][:owner_id]).first
      @pet.owner = @owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end