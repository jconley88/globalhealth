class Clinic < ActiveRecord::Base
  attr_accessible :name, :address_1, :city, :state, :zip, :phone, :email
  has_and_belongs_to_many :services
end
