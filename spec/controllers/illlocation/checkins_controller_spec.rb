require 'spec_helper'

module Illlocation
  describe CheckinsController do

    describe "POST 'create'" do      
      context "when a location and checkin is in the params" do
        let(:location) { build(:illlocation_location) }
        let(:checkin) { build(:illlocation_checkin) }
      
        it "returns http success" do          
          post 'create', use_route: :illlocation, checkin: checkin, location: location, format: :json
          
          expect(response).to be_success
        end
        
        it "saves the location if does not exist" do
          expect {
            post 'create', use_route: :illlocation, checkin: checkin, location: location, format: :json
          }.to change{ Location.count }.by(1)
        end
        
        it "does not save the location if it already exists" do
          create(:illlocation_location)
          
          expect {
            post 'create', use_route: :illlocation, checkin: checkin, location: location, format: :json
          }.not_to change{ Location.count }
        end

        it "returns the saved checkin" do
          post 'create', use_route: :illlocation, checkin: checkin, location: location, format: :json
        
          body = JSON.parse(response.body)
          Checkin.new(body) == Checkin.first
        end
        
      end
      
      context "when a location is not in the params" do
        pending "write tests for this" do
        end
      end
      
      context "when locatable is not in the params" do
        pending "write tests for this" do
        end        
      end
    end

  end
end
