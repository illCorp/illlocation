module Illlocation
  class Location < ActiveRecord::Base
    validates :latitude, :longitude, :latlon, :radius, presence: true
    
    before_validation :set_latlon
    
    has_many :tags
    
    set_rgeo_factory_for_column(:latlon, RGeo::Geographic.spherical_factory(:srid => 4326))
    
    def add_tag(name)
      tags.create(name: name)
    end
    
    def remove_tag(name)
      tag = tags.where(name: name).first
      tag.destroy if tag
    end
    
    def has_tag?(name)
      tags.where(name: name).any?
    end
    
    private
    
    def set_latlon
      self.latlon = "POINT(#{longitude} #{latitude})"
    end
  end
end
