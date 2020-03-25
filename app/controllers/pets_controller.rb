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
    #If user selects an existing owner
    @owner = Owner.find(params[:pet][:owner_id]) if params[:pet][:owner_id] && params[:owner][:name].empty?
    #If user enters in a new owner
    @owner = Owner.create(params[:owner]) if !params[:owner][:name].empty?
    #Adding pet to the owner
    @owner.pets << @pet

    redirect to "pets/#{@pet.id}"
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
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name]) if !params[:pet][:name].empty?

    params[:owner][:name] = "" if params[:owner][:name] == @pet.owner.name

    params[:owner][:name].empty? ? @owner = Owner.find(params[:pet][:owner_id]) : @owner = Owner.create(params[:owner])

    @owner.pets << @pet

    redirect to "pets/#{@pet.id}"
  end
end