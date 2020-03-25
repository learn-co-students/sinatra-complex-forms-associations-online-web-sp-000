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

    # @pet = Pet.create(name: params["pet[name]"], owner_id: params["pet[owner_ids][]"])
    # binding.pry
    #
    # if !params["pet"]["name"].empty?
    #   @pet.owners << Owner.create(name: params["owner"]["name"])
    # end
    # redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
