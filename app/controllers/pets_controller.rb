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
    #binding.pry
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
        if Owner.all.include?(name: params["owner"]["name"])
          @pet.owner = Owner.find_by name: params["owner"]["name"]
          @pet.save
        else
          @pet.owner = Owner.create(name: params["owner"]["name"])
          @pet.save
        end
    else
        @pet.owner = Owner.find_by id: params["owner"]["id"]
        @pet.save
    end
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    #binding.pry
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = params[:owner]
    @pet.update(params[:pet])
    #binding.pry
    if params[:owner][:name].empty?
      Owner.all.find_by id: params[:owner][:id]
      new_owner = Owner.find_by id: params[:owner][:id]
      @pet.update(owner: new_owner)
    else
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end
    #if owner exists(Owner.find_by[:name]), pet.owner = Owner.find_byname
    #else pet.owner = Owner.create(name: params["owner"]["name"])
    redirect to "pets/#{@pet.id}"
  end
end
