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
    if params[:owner_id]
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    else 
      @owner = Owner.new(name: params[:owner_name])
      @pet = Pet.new(name: params[:pet_name])
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
    @pet.update(name: params[:pet_name])
    @pet.owner = Owner.find(params[:owner_id])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name]) 
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end