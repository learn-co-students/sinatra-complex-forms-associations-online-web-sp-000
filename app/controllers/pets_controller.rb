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
    check_for_errors

    #decide whether to create an owner
    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner])
    else
      owner = Owner.find(params[:pet][:owner_ids].first)      
    end

    #create pet
    owner.pets.create(name: params[:pet][:name], owner: owner)

    #redirect
    redirect to "pets/#{owner.pets.last.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 

    #check for errors first
    check_for_errors

    #decide whether to create an owner  
    if !params[:owner][:name].empty?
      new_owner = Owner.create(params[:owner])
    elsif
      new_owner = Owner.find(params[:pet][:owner_ids].first)
    end

    #update pet
    pet = Pet.find(params[:id])
    pet.update(name: params[:pet][:name], owner: new_owner)

    #redirect
    redirect to "pets/#{pet.id}"
  end

  #helpers
  def check_for_errors

    ## BUG FIX
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end
    ##

    #show error if no pet name
    if params[:pet][:name].empty?
      return erb :'/pets/failures/name'
    #show error if > 1 owner selected
    elsif params[:pet][:owner_ids].size > 1
      return erb :'/pets/failures/multiple_owners'
    end   

  end

end