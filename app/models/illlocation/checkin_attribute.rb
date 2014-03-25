module Illlocation
  class CheckinAttribute < ActiveRecord::Base
    validates :key, :value, presence: true
        
    belongs_to :checkin
  end
end
