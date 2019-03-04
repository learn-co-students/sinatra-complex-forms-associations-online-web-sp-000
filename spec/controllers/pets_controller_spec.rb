require 'spec_helper'

describe "Pets Controller" do
  describe "new action" do

    it "can visit '/pets/new'" do
      get '/pets/new'
      expect(last_response.status).to eq(200)
    end

    it " loads form to create a new pet" do
      visit '/pets/new'
      expect(page).to have_field('pet_name')
    end


    it "has a field for creating a new owner" do
      visit '/pets/new'
      expect(page).to have_field(:owner_name)
    end

  end

  describe "edit action" do
    before(:each) do
      @owner = Owner.create(:name => "Carla")
      @pet = Pet.create(:name => "Chewie", :owner_id => @owner.id)
    end

    it "can visit '/owners/:id/edit' " do
      get "/owners/#{@owner.id}/edit"
      expect(last_response.status).to eq(200)
    end


  end

end
