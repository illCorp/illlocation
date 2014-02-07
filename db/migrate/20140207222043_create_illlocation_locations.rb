class CreateIlllocationLocations < ActiveRecord::Migration
  SPATIAL_REFERENCE_ID = 4326
  SPATIAL_DATA_TYPE = "point"
  
  def change
    create_table :illlocation_locations do |t|
      t.string   "latitude"
      t.string   "longitude"
      t.spatial  "latlon", :limit => {:srid => SPATIAL_REFERENCE_ID, :type => SPATIAL_DATA_TYPE, :geographic => true}
      t.string   "altitude"
      t.timestamps
    end
  end
end
