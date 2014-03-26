require 'spec_helper'

module Illlocation
  describe Checkin do
    let(:latitude) { 39.9319 }
    let(:longitude) { 105.0658 }
    
    describe ".find_near_lat_lon" do
      it "returns a maximum of the given limit" do
        filters = { limit: 1 }
        
        Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 1, locatable_type: "User")
        Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 2, locatable_type: "User") 
                  
        results = Checkin.find_near_lat_lon(latitude, longitude, filters)
        expect(results.count).to eq(1)
      end  
    end
    
    it "only returns checkins within the given distance" do
      broomfield_latitude = "39.9319"
      broomfield_longitude = "105.0658"
      tokyo_latitude = "35.6895"
      tokyo_longitude = "139.6917"
      
      broomfield_checkin = Checkin.create(latitude: broomfield_latitude, longitude: broomfield_longitude, locatable_id: 1, locatable_type: "User")
      tokyo_checkin = Checkin.create(latitude: tokyo_latitude, longitude: tokyo_longitude, locatable_id: 1, locatable_type: "User")
      
      filters = { distance: 400 }
        
      results = Checkin.find_near_lat_lon(broomfield_latitude, broomfield_longitude, filters)
      
      expect(results.count).to eq(1)
      expect(results.first).to eq(broomfield_checkin)
    end
    
    it "only returns checkins with locatable_types when given" do
      filters = { locatable_types: ["User", "Airplane"] }
      
      user_checkin = Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 1, locatable_type: "User")
      shark_checkin = Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 2, locatable_type: "Shark")
      airplane_checkin = Checkin.create(latitude: "39.9319", longitude: "105.0658", locatable_id: 3, locatable_type: "Airplane")

      results = Checkin.find_near_lat_lon(latitude, longitude, filters)
      
      expect(results.count).to eq(2)
      expect(results).to match_array([user_checkin, airplane_checkin])
    end
    
    describe "#add_attributes" do
      let(:checkin) { create(:illlocation_checkin) }
      
      it "adds a checkin attribute" do
        checkin.add_attributes({avatar_url: "http://sharknadotracker.com/users/1/profile.png"})
        
        expect(checkin.checkin_attributes.count).to eq(1)
      end
      
      it "converts the key to a string if it is passed as a symbol" do
        checkin.add_attributes({avatar_url: "http://sharknadotracker.com/users/1/profile.png"})
        
        expect(checkin.checkin_attributes.first.key).to eq("avatar_url")
      end
      
      it "adds multiple checkin attributes" do
        checkin.add_attributes(
          {
            avatar_url: "http://sharknadotracker.com/users/1/profile.png",
            last_comment: "fantastic ribs!"
          }
        )
        
        expect(checkin.checkin_attributes.count).to eq(2)
      end
    end
    
    describe ".find_in_box" do
      let(:colorado_box) {
        colorado_top_left_latitude = 41.0004
        colorado_top_left_longitude = -109.0497
        colorado_bottom_right_latitude = 36.9937
        colorado_bottom_right_longitude = -102.0424
        
        box = { 
          top_left: { 
            latitude: colorado_top_left_latitude, 
            longitude: colorado_top_left_longitude 
          }, 
          bottom_right: { 
            latitude: colorado_bottom_right_latitude, 
            longitude: colorado_bottom_right_longitude 
          }
        }
        box
      }
      
      let!(:broomfield_checkin) {
        broomfield_latitude = 39.9319
        broomfield_longitude = 105.0658
        Checkin.create(latitude: broomfield_latitude, longitude: broomfield_longitude, locatable_id: 1, locatable_type: "User")
      }

      let!(:denver_checkin) {
        denver_latitude = 39.7392
        denver_longitude = 104.9847
        Checkin.create(latitude: denver_latitude, longitude: denver_longitude, locatable_id: 1, locatable_type: "User")
      }
      
      let!(:tokyo_checkin) {
        tokyo_latitude = 35.6895
        tokyo_longitude = 139.6917
        Checkin.create(latitude: tokyo_latitude, longitude: tokyo_longitude, locatable_id: 1, locatable_type: "User")
      }
      
      it "only returns checkins that are within the box" do
        raise "pick up here"
      end
      
    end
    
    describe "#remove_attribute_with_key" do
      let(:checkin) { create(:illlocation_checkin) }
      
      before do
        checkin.add_attributes(
          {
            avatar_url: "http://sharknadotracker.com/users/1/profile.png",
            last_comment: "fantastic ribs!"
          }
        )
      end
        
      it "only removes the attribute with the given key" do
        checkin.remove_attribute_with_key("avatar_url")
        
        expect(checkin.checkin_attributes.count).to eq(1)
      end
    end
    
    describe "#has_attribute?" do
      let(:checkin) { create(:illlocation_checkin) }
      
      before do
        checkin.add_attributes({avatar_url: "http://sharknadotracker.com/users/1/profile.png"})
      end
      
      it "returns true if the attribute exists" do
        expect(checkin.has_attribute?("avatar_url")).to be true
      end
      
      it "return false if the attribute does not exist" do
        expect(checkin.has_attribute?("checkin_time")).to be false
      end
    end
  end
end
