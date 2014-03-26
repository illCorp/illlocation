require 'spec_helper'

module Illlocation
  describe CheckinsController do
    describe "POST 'create'" do
      context "when a location and checkin is in the params" do
        let(:params) do
          {
            checkin: {
              locatable_id: 1,
              locatable_type: "User",
              latitude: "39.9319",
              longitude: "105.0658"
            }
          }
        end
              
        it "returns http success" do
          post :create, params.merge!(use_route: :illlocation).merge!(format: :json)
          
          expect(response).to be_success
        end
       
        it "returns the saved checkin" do
          post :create, params.merge!(use_route: :illlocation).merge!(format: :json)
       
          body = JSON.parse(response.body)
          Checkin.new(body) == Checkin.first
        end
      end
    end
    
    describe "GET 'find_near_lat_lon'" do
      let(:params) do
        {
          latitude: 39.9319,
          longitude: 105.0658,
          limit: 5, 
          distance: 400, 
          locatable_types: "[User, Airplane]", 
          earliest_timestamp: "2013-03-25T15:27:15-06:00", 
          latest_timestamp: "2014-03-25T15:27:15-06:00",
          non_allowable_filter: "blah blah"
        }
      end
      
      it "forwards valid filters to the find method" do
        expect(Checkin).to receive(:find_near_lat_lon).with(
          39.9319,
          105.0658,
          {
            limit: 5, 
            distance: 400, 
            locatable_types: "[User, Airplane]", 
            earliest_timestamp: "2013-03-25T15:27:15-06:00", 
            latest_timestamp: "2014-03-25T15:27:15-06:00"
          }
        )
        
        get :find_near_lat_lon, params.merge!(use_route: :illlocation).merge!(format: :json)
      end
    end
  end
end