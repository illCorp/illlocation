require 'spec_helper'

module Illlocation
  describe CheckinsController do
    describe "POST 'create'" do
      context "when a location and checkin is in the params" do
        let(:params) do
          {
            checkin: {
              locatable_id: 1,
              locatable_type: "User"
            },
            location: {
              latitude: "39.9319",
              longitude: "105.0658",
              altitude: "1724"      
            }
          }
        end
              
        it "returns http success" do
          post :create, params.merge!(use_route: :illlocation).merge!(format: :json)
          
          expect(response).to be_success
        end
        
        it "saves the location if does not exist" do
          expect {
            post :create, params.merge!(use_route: :illlocation).merge!(format: :json)
          }.to change{ Location.count }.by(1)
        end
       
        it "does not save the location if it already exists" do
          create(:illlocation_location)
         
          expect {
            post :create, params.merge!(use_route: :illlocation).merge!(format: :json)
          }.not_to change{ Location.count }
        end
       
        it "returns the saved checkin" do
          post :create, params.merge!(use_route: :illlocation).merge!(format: :json)
       
          body = JSON.parse(response.body)
          Checkin.new(body) == Checkin.first
        end
      end
    end
  end
end