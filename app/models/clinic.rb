class Clinic < ActiveRecord::Base
  attr_accessible :clinic_id, :name, :price, :address, :city, :state, :zip, :practice_director, :medical_director, :lab_director, :phone, :fax, :link, :email, :donor_egg, :gest_carrier, :donor_embryo, :cryopres, :single_women, :accred, :icsi, :pgd, :quality, :donor_transfers, :donor_births, :donor_rank
  has_and_belongs_to_many :services

  def distance_in_miles
    rand * 3000
  end

  def quality=(stat)
    @quality = stat
  end

  def quality
    (@quality.to_f * 100).to_i
  end

  def price
    ((0.5 * quality / 100) * (rand * (50000))).round(-3) + 15000
  end
  alias_method :distance, :distance_in_miles
end
