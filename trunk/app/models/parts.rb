class Parts < ActiveRecord::Base
  has_and_belongs_to_many :machines
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :physical_test_methods
  has_and_belongs_to_many :composite_structures
  has_and_belongs_to_many :post_processing_techniques
  has_many :operating_parameters
  belongs_to :intended_uses
  has_one :optical_property
  has_one :thermal_property
  has_one :mechanical_property
  has_one :electrical_property
  has_one :chemical_property
  
end
