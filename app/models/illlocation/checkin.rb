module Illlocation
  class Checkin < ActiveRecord::Base
    validates :latitude, :longitude, :latlon, :locatable_id, :locatable_type, presence: true
    
    before_validation :set_latlon
    
    has_many :checkin_attributes
    
    DEFAULT_SEARCH_LIMIT = 50
    DEFAULT_SEARCH_DISTANCE_METERS = 1600
    
    def self.find_near_lat_lon(latitude, longitude, filters = {})
      limit = filters[:limit].nil? ? DEFAULT_SEARCH_LIMIT : filters[:limit]
      distance = filters[:distance].nil? ? DEFAULT_SEARCH_DISTANCE_METERS : filters[:distance]
      locatable_types = filters[:locatable_types].nil? ? [] : filters[:locatable_types]
      earliest_timestamp = filters[:earliest_timestamp]
      latest_timestamp = filters[:latest_timestamp]
      
      center = "'POINT(#{longitude} #{latitude})'"
      
      sql = "SELECT illlocation_checkins.*, ST_Distance(illlocation_checkins.latlon, #{center}) as distance 
             FROM illlocation_checkins
             WHERE ST_DWithin(illlocation_checkins.latlon, #{center}, #{distance}) "

      if locatable_types.any?
        locatable_types_string = "'#{filters[:locatable_types].join("','")}'"
        sql << "AND illlocation_checkins.locatable_type IN (#{locatable_types_string}) "
      end
      
      # TODO: creation time filters
      #if earliest_timestamp && latest_timestamp
      #elsif earliest_timestamp && latest_timestamp.nil?
      #elsif earliest_timestamp.nil? && latest_timestamp
      #end
      
      sql << "ORDER BY distance ASC LIMIT #{limit};"

      puts sql
      find_by_sql(sql)
    end
    
    def self.find_in_box(box, filters = {})
      min_x = box[:top_left][:longitude]
      max_x = box[:bottom_right][:longitude]
      min_y = box[:bottom_right][:latitude]
      max_y = box[:top_left][:latitude]
      
      locatable_types = filters[:locatable_types].nil? ? [] : filters[:locatable_types]
      
      sql = "SELECT illlocation_checkins.*
             FROM illlocation_checkins 
             WHERE ST_Intersects(latlon, ST_MakeEnvelope(#{min_x}, #{min_y}, #{max_x}, #{max_y})) "             

      if locatable_types.any?
        locatable_types_string = "'#{filters[:locatable_types].join("','")}'"
        sql << "AND illlocation_checkins.locatable_type IN (#{locatable_types_string}) "
      end

      puts sql
      find_by_sql(sql)
    end
    
    def self.find_in_box_with_cluster
      # TODO:
      #sql = "SELECT illlocation_checkins.*, foo.cluster_checkin_count as cluster_checkin_count, foo.cluster_center as cluster_center 
      #       FROM location_checkins, 
      #          (SELECT max(id) as last_id, COUNT(latlon) AS cluster_checkin_count, ST_AsText(ST_Centroid(ST_Collect(Geometry(latlon)))) AS cluster_center 
      #          FROM location_checkins 
      #          WHERE ST_Intersects(latlon, ST_MakeEnvelope(#{window[:min_x]},#{window[:min_y]},#{window[:max_x]}, #{window[:max_y]}))
      #          AND locatable_type='#{layer}' AND deleted_at IS NULL #{exclusion_clause} 
      #          GROUP BY ST_SnapToGrid(ST_SetSRID(Geometry(latlon), 4326), #{grid_scale}) ORDER BY cluster_checkin_count DESC) as foo
      #       WHERE location_checkins.id=foo.last_id"  
    end
    
    def add_attributes(checkin_attributes_hash = {})
      checkin_attributes_hash.each do |key, value|
        checkin_attributes.create(key: key.to_s, value: value)        
      end
    end
    
    def remove_attribute_with_key(key)
      attribute = checkin_attributes.where(key: key).first
      attribute.destroy if attribute
    end
    
    def has_attribute?(key)
      checkin_attributes.where(key: key).any?
    end
    
    private
    
    def set_latlon
      self.latlon = "POINT(#{longitude} #{latitude})"
    end
  end
end
