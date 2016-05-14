class RanchadasController < ApplicationController
  include ApplicationHelper
  before_action :set_ranchada, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web

  # GET /ranchadas
  # GET /ranchadas.json
  def index
     @filterrific = initialize_filterrific(
      Ranchada,
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
    @ranchadas = @filterrific.find.activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /ranchadas/1
  # GET /ranchadas/1.json
  def show
  end

  # GET /ranchadas/new
  def new
    @ranchada = Ranchada.new
    loadDefaultDropdowns(@ranchada)
  end

  # GET /ranchadas/1/edit
  def edit
    @ranchada.area_id = @ranchada.zone.area_id
    @zonas = Zone.where(:area_id => @ranchada.zone.area.id)
  end

  # POST /ranchadas
  # POST /ranchadas.json
  def create
    @ranchada = Ranchada.new(ranchada_params)
    @ranchada.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @ranchada.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::RANCHADA, @ranchada
        format.html { redirect_to ranchadas_url, notice: 'Ranchada creada correctamente.' }
        format.json { render :show, status: :created, location: @ranchada }
        format.js { render :show, status: :created, location: @ranchada }
      else
        if @ranchada.zone
          @zonas = Zone.where(:area_id => @ranchada.zone.area.id)
        else
          @zonas = Zone.zonas_primer_area
          @ranchada.area_id = @zonas.first.area_id
          @ranchada.zone_id = @zonas.first.id
        end
        format.html { render :new }
        format.json { render json: @ranchada.errors, status: :unprocessable_entity }
        format.js   { render json: @ranchada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ranchadas/1
  # PATCH/PUT /ranchadas/1.json
  def update
    respond_to do |format|
      if @ranchada.update(ranchada_params)
        actualizar_dependencias
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::RANCHADA, @ranchada
        format.html { redirect_to ranchadas_url, notice: I18n.t('common.exito.actualizacion_ranchada') }
        format.json { render :show, status: :ok, location: @ranchada }
      else
        if @ranchada.zone
          @zonas = Zone.where(:area_id => @ranchada.zone.area.id)
        else
          @zonas = Zone.zonas_primer_area
          @ranchada.area_id = @zonas.first.area_id
          @ranchada.zone_id = @zonas.first.id
        end

        format.html { render :edit }
        format.json { render json: @ranchada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranchadas/1
  # DELETE /ranchadas/1.json
  def destroy
    RanchadaDataAccess.borrar_logico(@ranchada)
    AuditoriaDataAccess.log current_user, Auditoria::BAJA, Auditoria::RANCHADA, @ranchada
    respond_to do |format|
      format.html { redirect_to ranchadas_url, notice: I18n.t('common.exito.borrado_ranchada') }
      format.json { head :no_content }
    end
  end

  private

    def actualizar_dependencias
      PersonDataAccess.actualizar_dependencias_ranchada @ranchada
      FamiliaDataAccess.actualizar_dependencias_ranchada @ranchada
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_ranchada
      @ranchada = Ranchada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ranchada_params
      params.require(:ranchada).permit(:nombre, :area_id, :zone_id, :descripcion, :latitud, :longitud)
    end
end
