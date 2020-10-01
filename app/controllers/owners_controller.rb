class OwnersController < ApplicationController

  get '/owners' do #read all
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do #create
    @pets = Pet.all   #why do we have to see all pets? #how does it access the Pet class?
    erb :'/owners/new'
  end

  post '/owners' do #create
    @owner = Owner.create(params[:owner])  #why is here params[:owner] with a symbol
    if !params["pet"]["name"].empty?   #and here it is params["pet"]["name"]
      @owner.pets << Pet.create(name: params["pet"]["name"])  #why are we creating this way, why not Pet.create(params[:pet])


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
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect "/owners/#{@owner.id}"
  end
end