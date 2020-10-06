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

    if !params[:pet][:name].empty? #if not empty string
      newpet = Pet.create(name: params[:pet][:name]) 
      @owner.pets << newpet
      #When using the shovel operator, ActiveRecord instantly fires update SQL without waiting for the save or update call on the parent object, unless the parent object is a new record.
    end

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
        ####### bug fix
        #The bug fix is required so that it's possible to remove ALL previous pets from owner.
        #they didn't explain. and it makes no sense
        #this seems to turn it into an empty array but apparnetly its a fix.


        if !params[:owner].keys.include?("pet_ids")
          params[:owner]["pet_ids"] = []
          end

          #######
      
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])

    if !params[:pet][:name].empty? #if not empty string
      newpet = Pet.create(name: params[:pet][:name]) 
      @owner.pets << newpet
    end

    redirect "/owners/#{@owner.id}"

  end
end