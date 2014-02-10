require_dependency "illlocation/application_controller"

module Illlocation
  class CheckinsController < ApplicationController
    def create
      @checkin = Checkin.new(checkin_params)
      @checkin.location = Location.where(location_params).first_or_create
      
      respond_to do |format|
        if @checkin.save
          format.json { render :json => @checkin }
        else
          format.json { render :json => {:errors => @checkin.errors.full_messages}, :status => :unprocessable_entity }
        end
      end
    end
    
    private
  
    def checkin_params
      params
        .require(:checkin)
        .permit(:location_id, :locatable_id, :locatable_type)
    end
  
    def location_params
      params
        .require(:location)
        .permit(:latitude, :longitude, :altitude)
    end
  end
end
