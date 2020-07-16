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

     ####### bug fix
     if !params[:pet].keys.include?("owner_id")
       params[:pet]["owner_id"] = []
     end
       #######
    if !params[:owner][:name].empty?
     @owner = Owner.create(params[:owner])
     params[:pet]["owner_id"] = @owner.id
    end
 
     @pet = Pet.create(params[:pet])
     redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end


  patch '/pets/:id' do 
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      params[:pet][:owner_id] = @owner.id
    end

    @pet = Pet.find(params[:id])
    
    @pet.update(params[:pet])
    #binding.pry

    redirect to "pets/#{@pet.id}"
  end
end