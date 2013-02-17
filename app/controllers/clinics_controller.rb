class ClinicsController < ApplicationController
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

  # GET /Clinics/new
  # GET /Clinics/new.json
  def new
    @clinic = Clinic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clinic }
    end
  end

  # GET /Clinics/1/edit
  def edit
    @clinic = Clinic.find(params[:id])
  end

  # POST /Clinics
  # POST /Clinics.json
  def create
    @clinic = Clinic.new(params[:Clinic])

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to @clinic, notice: 'Clinic was successfully created.' }
        format.json { render json: @clinic, status: :created, location: @clinic }
      else
        format.html { render action: "new" }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Clinics/1
  # PUT /Clinics/1.json
  def update
    @clinic = Clinic.find(params[:id])

    respond_to do |format|
      if @clinic.update_attributes(params[:Clinic])
        format.html { redirect_to @clinic, notice: 'Clinic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Clinics/1
  # DELETE /Clinics/1.json
  def destroy
    @clinic = Clinic.find(params[:id])
    @clinic.destroy

    respond_to do |format|
      format.html { redirect_to Clinics_url }
      format.json { head :no_content }
    end
  end
end
