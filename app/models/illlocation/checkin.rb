module Illlocation
  class Checkin < ActiveRecord::Base
    validates :location_id, :locatable_id, :locatable_type, presence: true
    
    belongs_to :location
    
    DEFAULT_SEARCH_LIMIT = 50
    DEFAULT_SEARCH_DISTANCE_METERS = 1600
    
    def self.find_near_lat_lon(latitude, longitude, limit, distance, locatable_types)
      limit = DEFAULT_SEARCH_LIMIT if limit.nil?
      distance = DEFAULT_SEARCH_DISTANCE_METERS if distance.nil?
      
      center = "'POINT(#{longitude} #{latitude})'"
      locatable_types_string = "'#{locatable_types.join("','")}'"
      
      if locatable_types.any?
        sql = "SELECT illlocation_checkins.*, ST_Distance(illlocation_locations.latlon, #{center}) as distance 
               FROM illlocation_checkins
               INNER JOIN illlocation_locations ON illlocation_checkins.location_id = illlocation_locations.id
               WHERE ST_DWithin(illlocation_locations.latlon, #{center}, #{distance})
               AND illlocation_checkins.locatable_type IN (#{locatable_types_string})
               ORDER BY distance ASC 
               LIMIT #{limit}"
      else
        sql = "SELECT illlocation_checkins.*, ST_Distance(illlocation_locations.latlon, #{center}) as distance 
               FROM illlocation_checkins
               INNER JOIN illlocation_locations ON illlocation_checkins.location_id = illlocation_locations.id
               WHERE ST_DWithin(illlocation_locations.latlon, #{center}, #{distance})
               ORDER BY distance ASC 
               LIMIT #{limit}"
      end

      puts sql
      find_by_sql(sql)
    end
  end
end
