class OwnersController < ApplicationController
  
  #read all owners-->index
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end
   
  #get new form
  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end
  
  #create/save new instance from params data hash got from new form
  post '/owners' do 
    @owner = Owner.create(params[:owner])
    
   
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect "/owners/#{@owner.id}"
  end

  #get edit form for specific instance
  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  #patch specific instance with params hash data from edit form
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
 
  #read/show specific instance
  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end
end