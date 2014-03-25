require 'spec_helper'

module Illlocation
  describe Checkin do
    # self.find_near_lat_lon covered in controller spec
    
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
