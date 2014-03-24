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
    
    describe "GET 'find_near_lat_lon'" do
      context "when a location is given without filters" do
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
      
      context "when a location is given with filters" do      
        it "returns a maximum of the given limit" do
          params = {
            latitude: "39.9319",
            longitude: "105.0658",
            limit: 1
          }
          
          location = Location.create(latitude: "39.9319", longitude: "105.0658")
          checkin = Checkin.create(location_id: location.id, locatable_id: 1, locatable_type: "User")
          another_checkin = Checkin.create(location_id: location.id, locatable_id: 1, locatable_type: "User") 
                    
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
          
          location = Location.create(latitude: "39.9319", longitude: "105.0658")
          Checkin.create(location_id: location.id, locatable_id: 1, locatable_type: "User")
          Checkin.create(location_id: location.id, locatable_id: 2, locatable_type: "Shark")
          Checkin.create(location_id: location.id, locatable_id: 3, locatable_type: "Airplane")
                    
          get :find_near_lat_lon, params.merge!(use_route: :illlocation).merge!(format: :json)
          
          body = JSON.parse(response.body)
          body.count.should == 2        
        end
      
        it "only returns checkins within the given distance" do
          broomfield = Location.create(latitude: "39.9319", longitude: "105.0658")
          tokyo = Location.create(latitude: "35.6895", longitude: "139.6917")

          broomfield_checkin = Checkin.create(location_id: broomfield.id, locatable_id: 1, locatable_type: "User")
          tokyo_checkin = Checkin.create(location_id: tokyo.id, locatable_id: 1, locatable_type: "User")
          
          params = {
            latitude: broomfield.latitude,
            longitude: broomfield.longitude,
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