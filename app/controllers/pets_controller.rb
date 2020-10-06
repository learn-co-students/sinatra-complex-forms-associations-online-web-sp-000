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
    #here its a bit different
    #becuase a pet only has one owner max

    #2 cases:
    #{"pet"=>{"name"=>"lucifer", "owner"=>{"name"=>"beyonce"}}}
    if !params[:pet][:owner][:name].empty? 
      #dont check whether owner_id exist, because the thing doesn't exist. u can't grab it. doesnt exist can be diff from nil. nil means have no value
      #the nil error is quite a headache
      #instead use the [:owner][:name] input because it's always gonna be there, empty string or not
      newowner = Owner.create(name: params[:pet][:owner][:name])
      @pet = Pet.create(name: params[:pet][:name], owner_id: newowner.id)

    else 
    #{"pet"=>{"name"=>"lucifer", "owner_id"=>"1", "owner"=>{"name"=>""}}}
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
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
    #will override old owner
    @pet = Pet.find(params[:id])


    #newline: 
    #@pet.update(params[:pet])
    #2 cases
    if !params[:owner][:name].empty? 
          #{"_method"=>"patch", "pet"=>{"name"=>"lulu"}, "owner"=>{"name"=>"linda"}, "id"=>"8"}

          #@pet.owner = Owner.create(name: params["owner"]["name"])
           newowner = Owner.create(name: params[:owner][:name])
           @pet.update(name: params[:pet][:name], owner_id: newowner.id)
    


    else 
          #{"_method"=>"patch", "pet"=>{"name"=>"lulu", "owner_id"=>"2"}, "owner"=>{"name"=>""}, "id"=>"8"}

          @pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    end
    #newline 
    #@pet.save
    redirect to "pets/#{@pet.id}"
  end

end