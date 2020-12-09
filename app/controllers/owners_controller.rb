require "pry"
class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do
    @pets = Pet.all 
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    #Create a new pet functionality
    redirect "/owners/#{@owner.id}"
    #raise params.inspect 
    #Remember this if you want to check if something's getting the right params data
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    #This is improper, it shouldn't be all pets it should be only the owner's pets
    #Or ... I'm not sure what should happen if the owner doesn't have any pets. It's a pet site. Surely an owner has pets?
    #I am massively overthinking this.
    erb :'/owners/edit'
    #@owner.update(params[:owner])
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
    ####### So it's possible to remove ALL pets from an owner
 
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
end
end