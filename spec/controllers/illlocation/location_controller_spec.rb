require 'spec_helper'

module Illlocation
  describe LocationController do

    describe "GET 'create'" do
      it "returns http success" do
        get 'create', use_route: :illlocation
        expect(response).to be_success
      end
    end

  end
end
