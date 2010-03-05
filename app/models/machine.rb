class Machine < ActiveRecord::Base
  belongs_to :am_technology
  belongs_to :company
  has_and_belongs_to_many :models
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :parts
  has_and_belongs_to_many :calibrations
  
end
