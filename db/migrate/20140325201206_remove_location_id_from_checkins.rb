class RemoveLocationIdFromCheckins < ActiveRecord::Migration
  def change
    remove_column :illlocation_checkins, :location_id
  end
end
