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
    
    @pet = Pet.create(:name => params[:pet_name])

    if params[:owner_id] == nil
      @owner = Owner.create(:name => params[:new_owner])
      @owner.pets << @pet
      
    else
      @owner = Owner.find_by_id(params[:owner_id])
      @owner.pets << @pet
      
    end
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end


  patch '/pets/:id' do 
     
    @pet = Pet.find_by_id(params[:id])
      binding.pry
      @pet.update(:name => params[:pet_name])
      
      if params[:owner][:name] == ""
        @owner = Owner.find_by_id(params[:owner_id])
      else
        @owner = Owner.create(params[:owner])
      end
      @owner.pets << @pet
      redirect "pets/#{@pet.id}"
end
end