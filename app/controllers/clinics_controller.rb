class ClinicsController < ApplicationController
  # POST /Clinics
  def search
  end

  # GET /Clinics
  # GET /Clinics.json
  def index
    zip = params[:zip_code]
    @clinics = Clinic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clinics.as_json(:methods => :distance) }
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
