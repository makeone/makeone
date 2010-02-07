class CadCamSoftware < ActiveRecord::Base
  has_and_belongs_to_many :companies
  has_many :models
end
