class PeopleController < ApplicationController
  include ApplicationHelper
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web
  before_action :puede_crear_persona, only: [:create]
  before_action :puede_editar_persona, only: [:update]
  before_action :puede_borrar_persona, only: [:destroy]

  # GET /people
  # GET /people.json
  def index
    if (params[:institucion_id])
      if !params[:filterrific]
        params[:filterrific] = Hash.new
      end
      params[:filterrific][:with_institucion_id] = params[:institucion_id]
    else
      session["people#index"] = nil
    end

    @filterrific = initialize_filterrific(
      Person,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select,
        with_zone_id: Zone.options_for_select,
        with_estado_id: Estado.options_for_select,
        with_departamento_id: Departamento.options_for_select
      },
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @people = @filterrific.find.includes(zone: [:area]).includes(:estado).includes(:departamentos).includes([:institucion]).activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

    # # Recover from invalid param sets, e.g., when a filter refers to the
    # # database id of a record that doesn’t exist any more.
    # # In this case we reset filterrific and discard all filter params.
    # rescue ActiveRecord::RecordNotFound => e
    #   # There is an issue with the persisted param_set. Reset it.
    #   puts "Had to reset filterrific params: #{ e.message }"
    #   redirect_to(reset_filterrific_url(format: :html)) and return
    # end
  end

  def update_zonas
    @zonas = Zone.where("area_id = ?", params[:area_id])
    if @zonas.length == 0
      @zonas.push(Zone.new(nombre: 'Ninguna', id: 0))
    end
    @selectorZona = params[:selector_zona]
    respond_to do |format|
      format.js
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    @person.visits.build
    loadDefaultDropdowns(@person)
  end

  # GET /people/1/edit
  def edit
    @person.area_id = @person.zone.area_id
    @zonas = Zone.where(:area_id => @person.area_id)
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.state = State.find_by_nombre('Actualizado');
    @person.visits.first.state = State.find_by_nombre('Actualizado');
    @person.visits.first.fecha = Time.now.to_date();
    @person.visits.first.descripcion = 'Persona vista por primera vez';

    respond_to do |format|
      if @person.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::PERSONA, @person
        format.html { redirect_to people_url, notice: 'Persona creada correctamente.' }
        format.json { render :show, status: :created, location: @person }
      else
        if @person.zone
          @zonas = Zone.where(:area_id => @person.zone.area_id)
        else
          loadDefaultDropdowns(@person)
        end

        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::PERSONA, @person
        format.html { redirect_to people_url, notice: 'Persona actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @person }
      else
        if @person.zone
          @zonas = Zone.where(:area_id => @person.zone.area_id)
        else
          @zonas = Zone.zonas_primer_area
          @person.area_id = @zonas.first.area_id
          @person.zone_id = @zonas.first.id
        end

        format.html { render :edit, zonas: @zonas }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    PersonDataAccess.borrar_logico(@person, current_user)
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Persona borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(
        {departamento_ids: []},
        :nombre,
        :apellido,
        :dni,
        :telefono,
        :fecha_nacimiento,
        :area_id,
        :zone_id,
        :estado_id,
        :page,
        :descripcion,
        :pantalon,
        :remera,
        :zapatillas,
        :institucion_id,
        visits_attributes: [:id, :descripcion, :latitud, :longitud])
    end
end
