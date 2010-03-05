class Scanners < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :models
  belongs_to :scanner_technology
end
