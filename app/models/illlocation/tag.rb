module Illlocation
  class Tag < ActiveRecord::Base
    validates :name, presence: true
    
    belongs_to :location
  end
end
