require 'spec_helper'

module Illlocation
  describe LocationsController do
    
    describe "POST 'create'" do
      let(:location) do
        {
          :latitude => "39.9319", 
          :longitude => "105.0658", 
          :altitude => "1724",
          :radius => 400
        }
      end
      
      it "returns http success" do          
        post 'create', use_route: :illlocation, location: location, format: :json
        
        expect(response).to be_success
      end
      
      it "returns the saved location" do
        post 'create', use_route: :illlocation, location: location, format: :json
        
        body = JSON.parse(response.body)
        Location.new(body) == Location.first
      end
      
      context "when the record is not valid" do
        let(:invalid_location) do
          {
            :latitude => nil, 
            :longitude => nil, 
            :altitude => "1724",
            :radius => 400
          }
        end
        
        it "does not return http success" do
          post 'create', use_route: :illlocation, location: invalid_location, format: :json
          
          response.should_not be_success
        end
    
        it "renders errors" do
          post 'create', use_route: :illlocation, location: invalid_location, format: :json
          
          body = JSON.parse(response.body)
          body.should have_key "errors"
        end
      end
    end
  end
end
