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
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
    else
      @owner = Owner.find(params[:pet][:owner_id].first)
    end
    @pet = @owner.pets.build(params[:pet])
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
    else
      @owner = Owner.find(params[:pet][:owner_id].first)
    end
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name], owner: @owner)
    redirect to "pets/#{@pet.id}"
  end
end