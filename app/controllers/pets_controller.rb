class PetsController < ApplicationController

    get '/pets/new' do
        erb :"/pets/new"
    end

    post '/pets' do
        @pet = Pet.create(params[:pet])
    
        if !params["owner"]["name"].empty?
          @pet.owner = Owner.create(name: params["owner"]["name"])
        end
    
        @pet.save
    
        redirect to "pets/#{@pet.id}"
      end

    get '/pets/:id/edit' do
        @pet = Pet.find(params[:id])
        @owner = Owner.find(@pet.owner_id)   
        erb :"/pets/edit"
    end

    patch '/pets/:id' do

        @pet = Pet.find(params[:id])
        @pet.update(params["pet"])
        if !params["owner"]["name"].empty?
          @pet.owner = Owner.create(name: params["owner"]["name"])
        end

        @pet.save

        redirect "pets/#{@pet.id}"
    end
end