class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners=Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if params[:pet][:owner_id]
      @pet=Pet.create(params[:pet])
    elsif params[:owner][:name] 
      owner=Owner.create(name: params[:owner][:name])
      @pet=Pet.create(name:params[:pet][:name], owner_id: owner.id)
    else params[:pet][:owner_id].empty? && params[:owner][:name].empty 
      redirect "/pets"
    end
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
   
    erb :'/pets/show'
  end

 get '/pets/:id/edit' do 
  @pet = Pet.find_by_id(params[:id])
  @owners=Owner.all
  erb :'/pets/edit'
 end 

  patch '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end


#update_name_params={pet"=>{"name"=>"Barbara", "owner_id"=>"31"}, "owner"=>{"name"=>""}, "id"=>"2"}
#params={"pet"=>{"name"=>"Barbara", "owner_id"=>"1"}, "owner"=>{"name"=>""}, "id"=>"2"}
#@pet = Pet.find(params["id"])
#@pet.update(owner_id: params["pet"]["owner_id"])
#params={"pet"=>{"name"=>"Barbara", "owner_id"=>"31"}, "owner"=>{"name"=>"Brutal"}, "id"=>"2"}
#owner=Owner.create(name: params["owner"]["name"])
#@pet = Pet.find_by_id(params["id"])
#@pet.update(owner_id: owner.id)
#@pet
#@pet.owner.name