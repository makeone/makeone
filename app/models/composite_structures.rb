class CompositeStructures < ActiveRecord::Base
  has_and_belongs_to_many :parts
  belongs_to :system
end
