class Company < ActiveRecord::Base
  has_many :machines
  has_many :materials
  has_and_belongs_to_many :cad_cam_software
  has_many :scanner_technologies
  has_many :scanners 
end
