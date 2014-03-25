require 'spec_helper'

module Illlocation
  describe Location do
    it "sets the latlon value before saving" do
      location = Illlocation::Location.create(
        :latitude => "39.9319", 
        :longitude => "105.0658", 
        :altitude => "1724"
      )
      
      location.latlon.should_not be_nil
      location.latlon.to_s.should == "POINT (105.0658 39.9319)"
    end
    
    describe "#add_tag" do
      let(:location) { create(:illlocation_location) }
      
      it "adds a tag with the given name" do
        location.add_tag("gas station")
        
        expect(location.tags.count).to eq(1)
        expect(location.tags.first.name).to eq("gas station")
      end
    end
    
    describe "#remove_tag" do
      let(:location) { create(:illlocation_location) }
      
      before do
        location.add_tag("gas station")
      end
      
      it "remove the tag with the given name" do
        location.remove_tag("gas station")
        
        expect(location.tags.count).to eq(0)
      end
    end
    
    describe "#has_tag?" do
      let(:location) { create(:illlocation_location) }
      
      before do
        location.add_tag("gas station")
      end
      
      it "returns true if the location has the tag" do
        expect(location.has_tag?("gas station")).to be true
      end
      
      it "returns false if the location does not have the tag" do
        expect(location.has_tag?("airport")).to be false 
      end
    end
  end
end
