class PetsController < ApplicationController
  get "/pets" do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get "/pets/new" do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post "/pets" do
    @pet = Pet.create(name: params[:pet_name])
    if !!params[:owner_id]
      Owner.find(params[:owner_id]).pets << @pet
    elsif !!params[:owner_name]
      Owner.create(name: params[:owner_name]).pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get "/pets/:id" do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get "/pets/:id/edit" do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch "/pets/:id" do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if params[:owner][:name].size > 0
      Owner.create(name: params[:owner][:name]).pets << @pet
    elsif !!params[:owner_id]
      Owner.find(params[:owner_id]).pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end
