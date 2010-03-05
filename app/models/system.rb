class System < ActiveRecord::Base
  has_many :composite_structures
  has_many :software
  has_many :electronics
end
