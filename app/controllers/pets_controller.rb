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
    
    @pet = Pet.new(name: params["pet"]["name"])
  
    if !params["owner"]["name"].empty? 
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
  
    if params["pet"]["owner_id"]
        params["pet"]["owner_id"].each do |o|
          own = Owner.find_by_id(o.to_i)
          own.pets << @pet
        end
      end
      @pet.save
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
    @pet.update(params[:pet])

    #binding.pry

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

end