class Age < ActiveRecord::Base
  attr_accessible :code, :name, :min_age, :max_age
end
