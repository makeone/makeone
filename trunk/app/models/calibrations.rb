class Calibrations < ActiveRecord::Base
  belongs_to :calibration_techniques
  has_and_belongs_to_many :machines
end
