class ScannerTechnologies < ActiveRecord::Base
  belongs_to :company
  has_many :scanners
end
