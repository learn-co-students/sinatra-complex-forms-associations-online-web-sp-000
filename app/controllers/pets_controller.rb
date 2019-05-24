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
    @pet = Pet.create(params[:owner])
    if !params["owner"]["name"].empty?
      @pet.owner << Pet.create(name: params["owner"]["name"])
    end
    redirect "owners/#{@pet.id}"

    redirect to "pets/#{@owner.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
          ####### bug fix
    if !params[:pet].keys.include?("owner_ids")
    params[:pet]["owner_ids"] = []
    end
    #######
 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner << Pet.create(name: params["owner"]["name"])
    end
    redirect "pets/#{@pet.id}"
    end

  
  
end