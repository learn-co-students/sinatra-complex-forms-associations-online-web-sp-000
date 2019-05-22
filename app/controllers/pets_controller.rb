class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @pets = Pet.all
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find_by_id(params[:id])
    erb :"/pets/edit"
  end

  patch '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    # binding.pry
    @pet.name = params[:pet][:name]
    if !params[:owner][:name].empty?
      # binding.pry
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      # binding.pry
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end
# binding.pry
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
