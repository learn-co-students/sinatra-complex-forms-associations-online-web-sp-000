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
    @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    if params[:owner_name] != ''
      owner = Owner.create(name: params[:owner_name])
      Pet.update(@pet.id, owner_id: owner.id)
    end
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end

  patch '/pets/:id' do
    owner = Owner.find(params[:owner][:name]) if params[:owner][:name]
    owner = Owner.create(name: params[:owner_name]) if params[:owner_name] != ''
    @pet = Pet.update(params[:id], name: params[:pet_name], owner_id: owner.id)
    redirect to "pets/#{@pet.id}"
  end
end