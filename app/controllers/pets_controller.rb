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
    @pet = Pet.create(params[:pet])

    if params[:owners][:new_owner]["name"] != ""
      @pet.owner = Owner.create(params[:owners][:new_owner])
      
    elsif !params["owners"]["owner_ids"].empty?
      @pet.owner = Owner.find_by_id(params["owners"]["owner_ids"])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.all.find_by_id(params[:id])
    erb :'/pets/edit'
  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  patch '/pets/:id' do 
    @pet = Pet.all.find_by_id(params[:id])

    # binding.pry
    
    if params[:owner][:name] != ""
      @pet.update(params[:pet])
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    
    else
      @pet.update(params[:pet])
    end

    redirect to "pets/#{@pet.id}"
  end

end