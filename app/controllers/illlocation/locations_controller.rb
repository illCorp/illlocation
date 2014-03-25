require_dependency "illlocation/application_controller"

module Illlocation
  class LocationsController < ApplicationController    
    def create
      @location = Location.new(location_params)
      
      respond_to do |format|
        if @location.save
          format.json { render :json => @location }
        else
          format.json { render :json => {:errors => @location.errors.full_messages}, :status => :unprocessable_entity }
        end
      end
    end
    
    private
    
    def location_params
      params.require(:location).permit(:latitude, :longitude, :altitude, :radius)
    end
  end
end
