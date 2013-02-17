class ClinicsController < ApplicationController
  # POST /Clinics
  def search
  end

  # GET /Clinics
  # GET /Clinics.json
  def index
    #filter by complication
    complication = Complication.find_by_code(params[:complication])
    @clinics = complication.present? ? complication.clinics : Clinic.all

    #assign clinic
    age = Age.find_by_code(params[:age])
    egg_type = EggType.find_by_code(params[:egg_type])
    @clinics.each do |clinic|
      if egg_type.present? && egg_type.code == 'donor'
        clinic.quality = clinic.donor_rank
      elsif age.present? && egg_type.present?
        stat = Stat.where(:age_id => age.id, :egg_type_id => egg_type.id, :stat_name_id => StatName.find_by_code('rank').id, :clinic_id => clinic.id).first
        clinic.quality = stat.value
      end
    end

    #sort clinic
    @clinics.sort_by!(&:rank).reverse!

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clinics.as_json(:methods => [:distance, :quality]) }
    end
  end

  # GET /Clinics/1
  # GET /Clinics/1.json
  def show
    @clinic = Clinic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clinic }
    end
  end
end
