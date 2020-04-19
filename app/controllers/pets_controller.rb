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
    @owner = Owner.find_by_id(params[:pet][:owner_id])
    
    if @owner == nil
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    @owner = @pet.owner
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    @owner = Owner.find_by_id(params[:owner][:id])
    @pet.update(name: params[:pet][:name])
    @owner.pets << @pet
    if !params["owner"]["name"].empty? 
      @owner = Owner.create(name: params[:owner][:name])
      @owner.pets << @pet
    end
   
    redirect to "pets/#{@pet.id}"
  end
end