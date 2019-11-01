class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @owners = Owner.all
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do

    #redirect to '/owners/new'
    @owner = Owner.create(params[:owner])
    @owner.save
    pet = Pet.create(params[:pet])
    pet.owner_id = @owner.id
    pet.save

    redirect to '/owners/' + @owner.id.to_s
  end

  get '/owners/:id/edit' do
    @pets = Pet.all
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    ####### bug fix
    if !params[:owner].keys.include?("pet_ids")
    params[:owner]["pet_ids"] = []
    end
    #######

    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end
end
