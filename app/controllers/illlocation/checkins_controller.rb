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
    
    def find_near_lat_lon
      latitude = find_params[:latitude]
      longitude = find_params[:longitude]
      
      # Not sure why these fields do not require strong params
      #limit = find_params.has_key?(:limit) ? find_params[:limit] : nil
      #distance = find_params.has_key?(:distance) ? find_params[:distance] : nil
      #locatable_types = find_params.has_key?(:locatable_types) ? find_params[:locatable_types] : []
      limit = params.has_key?(:limit) ? params[:limit] : nil
      distance = params.has_key?(:distance) ? params[:distance] : nil
      locatable_types = params.has_key?(:locatable_types) ? params[:locatable_types] : []

      @checkins = Checkin.find_near_lat_lon(latitude, longitude, limit, distance, locatable_types)
      
      respond_with(@checkins)
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
    
    def find_params
      params.permit(
        :latitude,
        :longitude,
        :limit,
        :distance,
        :locatable_types
      )
    end
  end
end
