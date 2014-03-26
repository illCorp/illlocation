require_dependency "illlocation/application_controller"

module Illlocation
  class CheckinsController < ApplicationController
    def create
      @checkin = Checkin.new(checkin_params)
      
      respond_to do |format|
        if @checkin.save
          format.json { render :json => @checkin }
        else
          format.json { render :json => {:errors => @checkin.errors.full_messages}, :status => :unprocessable_entity }
        end
      end
    end
    
    def find_near_lat_lon
      filters = params.merge(find_params).slice(:limit, :distance, :locatable_types, :earliest_timestamp, :latest_timestamp)
      @checkins = Checkin.find_near_lat_lon(find_params[:latitude], find_params[:longitude], filters)
      
      respond_with(@checkins)
    end
    
    private
  
    def checkin_params
      params
        .require(:checkin)
        .permit(:latitude, :longitude, :latlon, :locatable_id, :locatable_type)
    end
    
    def find_params
      params.permit(
        :latitude,
        :longitude,
        :limit,
        :distance,
        :locatable_types,
        :earliest_timestamp,
        :latest_timestamp
      )
    end
  end
end
