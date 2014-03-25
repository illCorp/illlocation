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
      context "when coordinates are given without filters" do
        let(:params) do
          {
            latitude: "39.9319",
            longitude: "105.0658"
          }
        end
      
        it "returns http success" do
          get :find_near_lat_lon, params.merge!(use_route: :illlocation).merge!(format: :json)
        
          expect(response).to be_success
        end
      end
      
      context "when a coordinates are given with filters" do      
        it "returns a maximum of the given limit" do
          params = {
            latitude: "39.9319",
            longitude: "105.0658",
            limit: 1
          }
          
          checkin = Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 1, locatable_type: "User")
          another_checkin = Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 1, locatable_type: "User") 
                    
          get :find_near_lat_lon, params.merge!(use_route: :illlocation).merge!(format: :json)
          
          body = JSON.parse(response.body)
          body.count.should == 1
        end
      
        it "only returns checkins with locatable_types when given" do
          params = {
            latitude: "39.9319",
            longitude: "105.0658",
            locatable_types: ["User", "Airplane"]
          }
          
          Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 1, locatable_type: "User")
          Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 2, locatable_type: "Shark")
          Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 3, locatable_type: "Airplane")
                    
          get :find_near_lat_lon, params.merge!(use_route: :illlocation).merge!(format: :json)
          
          body = JSON.parse(response.body)
          body.count.should == 2        
        end
      
        it "only returns checkins within the given distance" do
          broomfield_latitude = "39.9319"
          broomfield_longitude = "105.0658"
          tokyo_latitude = "35.6895"
          tokyo_longitude = "139.6917"

          broomfield_checkin = Checkin.create(latitude: broomfield_latitude, longitude: broomfield_longitude, locatable_id: 1, locatable_type: "User")
          tokyo_checkin = Checkin.create(latitude: tokyo_latitude, longitude: tokyo_longitude, locatable_id: 1, locatable_type: "User")
          
          params = {
            latitude: broomfield_latitude,
            longitude: broomfield_longitude,
            distance: 3
          }
            
          get :find_near_lat_lon, params.merge!(use_route: :illlocation).merge!(format: :json)
          
          body = JSON.parse(response.body)
          body.count.should == 1
          body.first['id'].should eq(broomfield_checkin.id)
        end
      end
    end
  end
end