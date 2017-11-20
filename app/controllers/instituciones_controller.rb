class InstitucionesController < ApplicationController
    before_action :set_institucion, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :puede_ver_web
    before_action :puede_crear_institucion, only: [:create]
    before_action :puede_editar_institucion, only: [:update]
    before_action :puede_borrar_institucion, only: [:destroy]

  def index
    @filterrific = initialize_filterrific(
      Institucion,
      params[:filterrific],
      select_options: {
        #with_area_id: Institucion.options_for_select
      },
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @instituciones = @filterrific.find.includes(:institucion_tipo).activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /instituciones/1
  # GET /instituciones/1.json
  def show
  end

  # GET /instituciones/new
  def new
    @institucion = Institucion.new
  end

  # GET /instituciones/1/edit
  def edit
  end

  # POST /instituciones
  # POST /instituciones.json
  def create
    @institucion = Institucion.new(institucion_params)
    @institucion.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @institucion.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::INSTITUCION, @institucion
        format.html { redirect_to instituciones_url, notice: 'Institución creada correctamente.' }
        format.json { render :show, status: :created, location: @institucion }
        format.js { render :show, status: :created, location: @institucion }
      else
        format.html { render :new }
        format.json { render json: @institucion.errors, status: :unprocessable_entity }
        format.js   { render json: @institucion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instituciones/1
  # PATCH/PUT /instituciones/1.json
  def update
    respond_to do |format|
      if @institucion.update(institucion_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::ZONA, @institucion
        format.html { redirect_to instituciones_url, notice: 'Institución actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @institucion }
      else
        format.html { render :edit }
        format.json { render json: @institucion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instituciones/1
  # DELETE /instituciones/1.json
  def destroy
    InstitucionDataAccess.borrar_logico(@institucion, current_user)
    respond_to do |format|
      format.html { redirect_to instituciones_url, notice: 'Institución borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institucion
      @institucion = Institucion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institucion_params
      params.require(:institucion).permit(:nombre, :codigo_postal, :contacto, :telefono, :direccion, :descripcion, :latitud, :longitud, :institucion_tipo_id)
    end
end
