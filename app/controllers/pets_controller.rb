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
    @owner = Owner.create(name: params[:owner_name])
    @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)

    if !params[:owner_id].empty?
      @pet = Pet.create(pet_params(params))
    end
    redirect to "pets/#{@pet.id}"
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
    @pet = Pet.find(params[:id])
    new_owner = Owner.find(params[:pet][:owner_id].to_i)
    
    if new_owner != @pet.owner
      new_owner_name = Owner.find(params[:pet][:owner_id]).name
      @pet.owner.update(name: new_owner_name)
    elsif params[:pet_name] != @pet.name 
      @pet.update(name: params[:pet_name]) 
    elsif !params[:owner][:name].empty?
      @pet.owner.update(name: params[:owner][:name])
    end
    redirect to "pets/#{@pet.id}"
  end

  private
  def pet_params(params)
    {  :name => params[:pet_name],
       :owner_id => params[:owner_id] 
    }
  end

end