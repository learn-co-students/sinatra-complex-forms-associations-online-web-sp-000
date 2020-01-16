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
    @pet = Pet.create(params[:pet])
    # binding.pry
    if !Owner.find_by_id(params[:owner][:id])
      @owner = Owner.new(params[:owner])
      @pet.owner = @owner
      @pet.save
    else
      @pet.owner = Owner.find_by_id(params[:owner][:id])
      @pet.save
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
    # binding.pry
    erb :'/pets/edit'

  end

  patch '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    if !!params[:pet][:name]
      @pet.name = params[:pet][:name]
    end
    # binding.pry
    if !!Owner.find_by_id(params[:pet][:owner_id]) && params[:owner][:name].empty?
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
      @pet.save
    else
      @owner = Owner.new(params[:owner])
      @pet.owner = @owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end