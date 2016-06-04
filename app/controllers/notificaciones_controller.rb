class NotificacionesController < ApplicationController
  include ApplicationHelper
  before_action :set_notificacion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web

	def index
    @filterrific = initialize_filterrific(
      Notificacion,
      params[:filterrific],
      select_options: {},
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @notificaciones = @filterrific.find.includes(:notificacion_tipo, :frecuencia_tipo).activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /notificacion/new
  def new
    @notificacion = Notificacion.new
  end

  # GET /notificacion/1/edit
  def edit
  end

  # POST /notificacion
  # POST /notificacion.json
  def create
    @notificacion = Notificacion.new(notificacion_params)
    @notificacion.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @notificacion.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::NOTIFICACION, @notificacion
        format.html { redirect_to notificaciones_url, notice: 'Notificación creada correctamente.' }
        format.json { render :show, status: :created, location: @notificacion }
      else
        format.html { render :new }
        format.json { render json: @notificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notificacion/1
  # PATCH/PUT /notificacion/1.json
  def update
    respond_to do |format|
      if @notificacion.update(notificacion_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::NOTIFICACION, @notificacion
        format.html { redirect_to notificaciones_url, notice: 'Notificación actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @notificacion }
      else
        format.html { render :edit }
        format.json { render json: @notificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notificacion/1
  # DELETE /notificacion/1.json
  def destroy
    NotificacionDataAccess.borrar_logico(@notificacion, current_user)
    respond_to do |format|
      format.html { redirect_to notificaciones_url, notice: 'Notificación borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notificacion
      @notificacion = Notificacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notificacion_params
      params.require(:notificacion).permit(
        :titulo,
        :subtitulo,
        :fecha_desde,
        :fecha_hasta,
        :notificacion_tipo,
        :descripcion,
        :frecuencia_tipo,
        roles_attributes: [:id]
      )
    end
end
