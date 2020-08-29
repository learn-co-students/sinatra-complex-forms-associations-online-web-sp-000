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
    @pet = Pet.create("name"=>params[:pet_name],"owner_id"=>params[:pet_owner])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
      @pet.save
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    # binding.pry
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    # binding.pry
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    # ####### bug fix
    # if !params[:owner].keys.include?("pet_ids")
    #   params[:owner]["pet_ids"] = []
    #   end
    #   #######
   
      @pet = Pet.find(params[:id])
      @owner = Owner.find(params[:owner_id])
      @pet.update(name: params[:pet_name],owner: @owner)
      # binding.pry
      if !params[:owner]["name"].empty?
      @pet.owner = Owner.create(name: params[:owner]["name"])
        @pet.save
      end
    
    redirect to "pets/#{@pet.id}"
  end
end