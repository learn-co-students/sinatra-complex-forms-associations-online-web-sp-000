  
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
    # binding.pry
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params[:owner])
      # binding.pry
      @pet.owner = @owner
      @pet.save
    end
    # binding.pry

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    # binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    # binding.pry
    @pet = Pet.find(params[:id])
    @owners = Owner.all
  
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    # binding.pry
    @pet = Pet.find(params[:id])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params[:owner])
      # binding.pry
      @pet.owner = @owner
      @pet.save
    else
      @pet.update(name: params[:pet_name], owner_id: params[:owner_id])    
    end
    # binding.pry

    redirect to "pets/#{@pet.id}"
  end

end