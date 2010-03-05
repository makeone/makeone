class IntendedUses < ActiveRecord::Base
  has_and_belongs_to_many :parts
end
