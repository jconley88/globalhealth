class Complication < ActiveRecord::Base
  attr_accessible :code, :name
  has_and_belongs_to_many :services
end
