module Illlocation
  class Location < ActiveRecord::Base
    before_save :set_latlon
    
    set_rgeo_factory_for_column(:latlon, RGeo::Geographic.spherical_factory(:srid => 4326))
    
    private
    
    def set_latlon
      self.latlon = "POINT(#{longitude} #{latitude})"
    end
  end
end
