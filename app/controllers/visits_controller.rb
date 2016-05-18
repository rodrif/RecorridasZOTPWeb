class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web
  before_action :puede_crear_visita, only: [:create]
  before_action :puede_editar_visita, only: [:update]
  before_action :puede_borrar_visita, only: [:destroy]

  def mobRecibirVisitasDesde    
    respuesta = VisitDataAccess.getVisitasDesde params['datos'], params['fecha']

    render :json => respuesta
  end

  # GET /visits
  # GET /visits.json
  def index
    if (params[:person_id])
      if !params[:filterrific]
        params[:filterrific] = Hash.new
      end
      params[:filterrific][:with_person_id] = params[:person_id]
    else
      session["visits#index"] = nil
    end

    @filterrific = initialize_filterrific(
      Visit,
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
    @visits = @filterrific.find.activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new
    @visit.fecha = Time.now.ago(1.days)

    if (params[:person_id])
      @visit.person_id = params[:person_id]
      ubicacion = PersonDataAccess.getUbicacionUltVisita(params[:person_id])
      if ubicacion
        @visit.latitud = ubicacion.latitud
        @visit.longitud = ubicacion.longitud
      else
        @visit.latitud = -34.6425867
        @visit.longitud = -58.5659176
      end
    end
  end

  # GET /visits/1/edit
  def edit
  end

  # POST /visits
  # POST /visits.json
  def create
    @visit = Visit.new(visit_params)
    @visit.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @visit.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::VISITA, @visita
        format.html { redirect_to visits_url(nil, person_id: @visit.person_id), notice: 'Visita creada correctamente.' }
        format.json { render :show, status: :created, location: @visit }
      else
        format.html { render :new }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visits/1
  # PATCH/PUT /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::VISITA, @visita
        format.html { redirect_to visits_url(nil, person_id: @visit.person_id), notice: 'Visita actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @visit }
      else
        params[:person_id] = @visit.person_id
        format.html { render :edit }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    VisitDataAccess.borrar_logico(@visit)
    respond_to do |format|
      format.html { redirect_to visits_url(:person_id => params[:person_id]), notice: 'Visita borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      params.require(:visit).permit(:descripcion, :fecha, :person_id, :latitud, :longitud)
    end
end
