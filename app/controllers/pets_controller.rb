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
    @pet = Pet.create(name: params[:pet][:name])
    if params[:pet].include?("owner_id")
      @pet.update(owner_id: params[:pet][:owner_id])
    else

      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner = @owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])

    if params[:owner][:name].empty?
      @owner = Owner.find(params[:owner][:id])
      @pet.owner = @owner
      @pet.save
    else
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner = @owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end
