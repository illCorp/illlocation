class AddLatLonToCheckins < ActiveRecord::Migration
  SPATIAL_REFERENCE_ID = 4326
  SPATIAL_DATA_TYPE = "point"
  
  def change
    add_column :illlocation_checkins, :latitude, :string
    add_column :illlocation_checkins, :longitude, :string
    add_column :illlocation_checkins, :latlon, :spatial, :limit => {:srid => SPATIAL_REFERENCE_ID, :type => SPATIAL_DATA_TYPE, :geographic => true}
  end
end
