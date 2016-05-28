class ZonesController < ApplicationController
  before_action :set_zone, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web

  # GET /zones
  # GET /zones.json
  def index
    @filterrific = initialize_filterrific(
      Zone,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select
      },
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @zones = @filterrific.find.activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /zones/1
  # GET /zones/1.json
  def show
  end

  # GET /zones/new
  def new
    @zone = Zone.new
  end

  # GET /zones/1/edit
  def edit
  end

  # POST /zones
  # POST /zones.json
  def create
    @zone = Zone.new(zone_params)
    @zone.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @zone.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::ZONA, @zone
        format.html { redirect_to zones_url, notice: 'Zona creada correctamente.' }
        format.json { render :show, status: :created, location: @zone }
        format.js { render :show, status: :created, location: @zone }
      else
        format.html { render :new }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
        format.js   { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zones/1
  # PATCH/PUT /zones/1.json
  def update
    respond_to do |format|
      if @zone.update(zone_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::ZONA, @zone
        format.html { redirect_to zones_url, notice: 'Zona actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @zone }
      else
        format.html { render :edit }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1
  # DELETE /zones/1.json
  def destroy
    ZoneDataAccess.borrar_logico(@zone, current_user)
    respond_to do |format|
      format.html { redirect_to zones_url, notice: 'Zona borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone
      @zone = Zone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zone_params
      params.require(:zone).permit(:nombre, :latitud, :longitud, :area_id)
    end
end
