class OwnersController < ApplicationController

  get '/owners' do #read all
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do #create
    @pets = Pet.all   #how does it access the Pet class? #the access here is trough has_many - belongs_to relatonship
    erb :'/owners/new'
  end

  post '/owners' do #create
    @owner = Owner.create(params[:owner])  #apparently this is the same thing as Owner.create(name: params[:owner][:name]) but just in this case bc we only have name as params
    
    if !params["pet"]["name"].empty?   
      
      @owner.pets << Pet.create(name: params[:pet][:name])  #since we are in owner, pet is created by the name input by user as a value in pet[name]
      

      # When using the shovel operator, ActiveRecord instantly fires update SQL
      # without waiting for the save or update call on the parent object,
      # unless the parent object is a new record.
    end
    redirect "/owners/#{@owner.id}"
  end


  get '/owners/:id' do #read one
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end


  get '/owners/:id/edit' do  #update
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  patch '/owners/:id' do #update
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end

    redirect "/owners/#{@owner.id}"
  end
end