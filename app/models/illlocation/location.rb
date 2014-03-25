module Illlocation
  class Location < ActiveRecord::Base
    validates :latitude, :longitude, :latlon, presence: true
    
    before_validation :set_latlon
    
    has_many :checkins
    has_many :tags
    
    set_rgeo_factory_for_column(:latlon, RGeo::Geographic.spherical_factory(:srid => 4326))
    
    private
    
    def set_latlon
      self.latlon = "POINT(#{longitude} #{latitude})"
    end
  end
end
