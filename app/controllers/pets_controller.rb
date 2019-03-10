class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(:name => params[:pet_name], :owner_id => params[:pet_owner])
    if !params[:owner_name].empty?
      @owner = Owner.create(:name => params[:owner_name])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet=Pet.find_by(:id => params[:id])
    if @pet 
       erb :'/pets/show'
    else
      redirect '/pets'
    end
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    if @pet
        erb :'/pets/edit'
    else
      redirect "/pets"
    end
  end

  patch '/pets/:id' do 
     
      @pet = Pet.find(params[:id])
      @pet.update(params["pet"])
      if !params["owner"]["name"].empty?
        @owner = Owner.create(name: params["owner"]["name"])
        @owner.pets << @pet
      end
      redirect to "pets/#{@pet.id}"
  end
end