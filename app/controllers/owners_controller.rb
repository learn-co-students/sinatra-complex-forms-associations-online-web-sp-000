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
    # create new owner AND associate pets via pet_ids
    if params[:owner][:name].empty?
      return erb :'/owners/failures/name'
    else
      @owner = Owner.create(params[:owner])
    end

    # if applicable, add new pet
    if !params[:pet][:name].empty? && !params[:owner][:name].empty?
      @owner.pets.create(params[:pet])
    end
    # alternative:
    # if !params["pet"]["name"].empty?
    #   @owner.pets << Pet.create(name: params["pet"]["name"])
    # end
    
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    ####### bug fix ############# NOTE: This is required so that it's possible to remove ALL previous pets from owner.
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end
    #######

    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])
    if !params[:pet][:name].empty?
      @owner.pets.create(params[:pet])
    end
    # can also use below:
    # if !params["pet"]["name"].empty?
    #   @owner.pets << Pet.create(name: params["pet"]["name"])
    # end
    redirect "owners/#{@owner.id}"
  end
end