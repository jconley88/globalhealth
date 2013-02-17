class Stat < ActiveRecord::Base
  attr_accessible :value, :age_id, :egg_type_id, :clinic_id, :stat_name_id
  has_one :clinic
  has_one :age
  has_one :egg_type
  has_one :stat_name
end
