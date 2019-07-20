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

  patch '/pets/:id' do 
    redirect to "pets/#{@pet.id}"
  end

  private
  def pet_params(params)
    {  :name => params[:pet_name],
       :owner_id => params[:owner_id] 
    }
  end

end