module Illlocation
  class Checkin < ActiveRecord::Base
    validates :location_id, :locatable_id, :locatable_type, presence: true
    
    belongs_to :location
  end
end
