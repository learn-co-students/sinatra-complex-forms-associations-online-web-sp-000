class PetsController <ApplicationController


  configure do
    enable :sessions
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "auth_demo_lv"
  end

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
   
    @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
       #attribute : data cooresponding

    end
    @pet.save
    redirect "/pets/#{@pet.id}"

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
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
      end
      @pet = Pet.find(params[:id])
      @pet.update(params["pet"]) 
      if !params["owner"]["name"].empty?
        owner = Owner.create(name: params["owner"]["name"])
        owner.pets << @pet
      end
  redirect "/pets/#{@pet.id}"

  end
end