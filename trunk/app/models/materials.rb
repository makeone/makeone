class Materials < ActiveRecord::Base
  has_and_belongs_to_many :machines
  belongs_to :company
  has_and_belongs_to_many :parts
end
