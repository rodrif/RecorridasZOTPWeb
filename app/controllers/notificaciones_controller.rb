class NotificacionesController < ApplicationController
  include ApplicationHelper
  before_action :set_notificacion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web

	def index
    @filterrific = initialize_filterrific(
      Notificacion,
      params[:filterrific],
      select_options: { with_notificacion_tipo: NotificacionTipo.options_for_select },
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @notificaciones = @filterrific.find.includes(:notificacion_tipo, :frecuencia_tipo, :roles).activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /notificacion/new
  def new
    @notificacion = Notificacion.new
    @notificacion.setup_roles!
  end

  # GET /notificacion/1/edit
  def edit
    @notificacion.setup_roles!
  end

  # POST /notificacion
  # POST /notificacion.json
  def create
    @notificacion = Notificacion.new(notificacion_params)
    @notificacion.state = State.find_by_nombre('Actualizado')
    @notificacion.prox_envio = @notificacion.fecha_desde
    @notificacion.finalizada = false
    # TODO si es unica y fecha_desde es en el pasado, enviarla y finalizarla
    respond_to do |format|
      if @notificacion.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::NOTIFICACION, @notificacion
        format.html { redirect_to notificaciones_url, notice: 'Notificación creada correctamente.' }
        format.json { render :show, status: :created, location: @notificacion }
      else
        @notificacion.setup_roles!
        format.html { render :new }
        format.json { render json: @notificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notificacion/1
  # PATCH/PUT /notificacion/1.json
  def update
    respond_to do |format|
      if @notificacion.finalizada
        exitoActualziar = @notificacion.update(notificacion_params)
        if @notificacion.fecha_desde_en_el_pasado
          exitoActualziar = false
        end
        @notificacion.prox_envio = @notificacion.fecha_desde
        @notificacion.finalizada = false
      else
        exitoActualziar = @notificacion.update(notificacion_params)
        if @notificacion.fecha_desde.past?
          @notificacion.calcularProxEnvio
        else
          @notificacion.prox_envio = @notificacion.fecha_desde
        end
      end
      if exitoActualziar
        @notificacion.save
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::NOTIFICACION, @notificacion
        format.html { redirect_to notificaciones_url, notice: 'Notificación actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @notificacion }
      else
        @notificacion.setup_roles!
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
        :notificacion_tipo_id,
        :descripcion,
        :frecuencia_cant,
        :frecuencia_tipo_id,
        notificacion_roles_attributes: [:_destroy, :id, :rol_id, :notificacion_id]
      )
    end
end
