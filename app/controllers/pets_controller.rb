class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      owner.pets << Pet.create(name: params[:pet_name])
      @pet = Pet.last
    else
      owner = Owner.find(params[:owner])
      owner.pets << Pet.create(name: params[:pet_name])
      @pet = Pet.last
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find(params[:owner][:id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end