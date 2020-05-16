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
    @pet = Pet.create(name: params[:pet][:name])
   
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      owner.pets << @pet
    elsif !params["pet"]["owner"].empty?
      @pet.owner = Owner.find(params["pet"]["owner"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    
    @pet = Pet.find_by_id(params[:id])
    @pet.update(name: params[:pet][:name])
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @owner.pets << @pet
    else
      @owner = Owner.find_by_id(params[:pet][:owner])
      @owner.pets << @pet
    end
      redirect "pets/#{@pet.id}"
  end
end

