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
    # binding.pry
    if !params["owner"]["name"].empty?
      # binding.pry
      @pet.owner = Owner.create(name: params["owner"]["name"])
      # binding.pry
      @pet.save
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'   
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    puts '|||||||||||||||||||||||||'
    puts '|||||||||||||||||||||||||'
    puts params[:owner][:name]
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      # binding.pry
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
      # binding.pry
    end
    # binding.pry
    erb :'/pets/show'
  end
end