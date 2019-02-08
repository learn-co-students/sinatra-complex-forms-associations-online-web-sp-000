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
   if !params["owner_name"].empty?
     @pet = Pet.create(name: params[:pet_name])
     @pet.owner = Owner.create(name: params[:owner_name])
     @pet.save
   else
     @pet = Pet.create(name: params[:pet_name])
     @owner = Owner.find_by(params[:owner_name])
     @pet.owner = @owner
     @pet.save
   end
   redirect to "pets/#{@pet.id}"
 end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
