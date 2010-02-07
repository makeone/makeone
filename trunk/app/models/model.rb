class Model < ActiveRecord::Base
  has_and_belongs_to_many :machines
  has_and_belongs_to_many :digital_test_methods
  has_and_belongs_to_many :scanners
  belongs_to :cad_cam_software
  belongs_to :format
  belongs_to :user
  has_many :versions
end
