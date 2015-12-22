class FamiliasController < ApplicationController
  before_action :set_familia, only: [:show, :edit, :update, :destroy]

  # GET /familias
  # GET /familias.json
  def index
      @filterrific = initialize_filterrific(
      Familia,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select,
        with_zone_id: Zone.options_for_select
      },
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @familias = @filterrific.find.order(:nombre).page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /familias/1
  # GET /familias/1.json
  def show
  end

  # GET /familias/new
  def new
    @familia = Familia.new
    @zonas = Zone.zonas_primer_area
    @ranchadas = Ranchada.where(:zone_id => @zonas.first.id)
  end

  # GET /familias/1/edit
  def edit
    @familia.area_id = @familia.zone.area_id
    @zonas = Zone.where(:area_id => @familia.zone.area_id)
    @ranchadas = Ranchada.where(:zone_id => @familia.zone_id)
  end

  # POST /familias
  # POST /familias.json
  def create
    @familia = Familia.new(familia_params)

    respond_to do |format|
      if @familia.save
        format.html { redirect_to familias_url, notice: 'Familia creada correctamente.' }
        format.json { render :show, status: :created, location: @familia }
        format.js { render :show, status: :created, location: @familia }
      else
        if @familia.zone
          @zonas = Zone.where(:area_id => @familia.zone.area_id)
          @ranchadas = Ranchada.where(:zone_id => @familia.zone_id)
        else
          @zonas = Zone.zonas_primer_area
          @ranchadas = Ranchada.where(:zone_id => @zonas.first.id)
          @familia.area_id = @zonas.first.area_id
          @familia.zone_id = @zonas.first.id
        end

        format.html { render :new }
        format.json { render json: @familia.errors, status: :unprocessable_entity }
        format.js   { render json: @familia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /familias/1
  # PATCH/PUT /familias/1.json
  def update
    respond_to do |format|
      if @familia.update(familia_params)
        PersonDataAccess.actualizar_dependencias_familia @familia
        format.html { redirect_to familias_url, notice: 'Familia actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @familia }
      else
        if @familia.zone
          @zonas = Zone.where(:area_id => @familia.zone.area.id)
          @ranchadas = Ranchada.where(:zone_id => @familia.zone_id)
        else
          @zonas = Zone.zonas_primer_area
          @ranchadas = Ranchada.where(:zone_id => @zonas.first.id)
          @familia.area_id = @zonas.first.area.id
          @familia.zone_id = @zonas.first.id
        end

        format.html { render :edit }
        format.json { render json: @familia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /familias/1
  # DELETE /familias/1.json
  def destroy
    @familia.destroy
    respond_to do |format|
      format.html { redirect_to familias_url, notice: 'Familia borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_familia
      @familia = Familia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def familia_params
      params.require(:familia).permit(:nombre, :area_id, :zone_id, :ranchada_id, :descripcion)
    end
end
