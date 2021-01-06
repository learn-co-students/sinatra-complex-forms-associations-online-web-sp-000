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
    if !(params["owner"]["name"].empty?)
      @pet.owner = Owner.create(name: params["owner"]["name"])
     # binding.pry
    end
    @pet.save
    #binding.pry
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    #binding.pry
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
   @pet = Pet.find(params[:id])
   #binding.pry
   @pet.name = params[:pet][:name]
   @owner = Owner.find(params[:pet][:owner])
    if (params[:owner][:name] != "")
      @owner = Owner.create(name: params[:owner][:name])
      @owner.pet_ids << @pet.id
      @owner.save
    end
    @pet.owner = @owner
    @pet.save
    #binding.pry
    redirect "/pets/#{@pet.id}"
  end



end