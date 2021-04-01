require 'spec_helper'

describe "Pets Controller" do
  describe "new action" do

    it "can visit '/pets/new'" do
      get '/pets/new'
      expect(last_response.status).to eq(200)
    end
  end
end 