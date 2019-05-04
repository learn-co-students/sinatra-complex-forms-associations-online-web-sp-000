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

    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    elsif params[:pet][:owner_id]
      @pet.owner_id = params[:pet][:owner_id].first
    end
    @pet.save
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
    if !params[:owner][:name].empty?
      @pet.update(name: params[:pet][:name], owner_id: Owner.create(name: params[:owner][:name]).id)
    elsif params[:pet][:owner_id]
      @pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id].first)
    end
    redirect to "pets/#{@pet.id}"
  end
end
