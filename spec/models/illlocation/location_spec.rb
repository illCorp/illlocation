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
  end
end
