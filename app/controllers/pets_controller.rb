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
    @pet = Pet.new(params[:pet])
    !params[:owner][:name].empty? ? @pet.owner = Owner.create(params[:owner]) : @pet.owner = Owner.find(params[:owner][:id])
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    if !params[:id].empty?
      @pet = Pet.find(params[:id])
    else
      erb :'/pets/index'
    end
    if !@pet.owner.name.empty?
      @owners = Owner.all
    end
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      owner = Owner.new
      owner.name = params[:owner][:name]
      owner.save
      @pet.owner = owner
    else
      @pet.owner = Owner.find(params[:owner][:id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
end