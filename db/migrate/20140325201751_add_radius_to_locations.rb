class AddRadiusToLocations < ActiveRecord::Migration
  def change
    add_column :illlocation_locations, :radius, :integer
  end
end
