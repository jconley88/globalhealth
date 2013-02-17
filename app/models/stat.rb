class Stat < ActiveRecord::Base
  attr_accessible :value
  has_one :clinic
  has_one :age
  has_one :egg_type
end
