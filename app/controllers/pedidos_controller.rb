class PedidosController < ApplicationController
    before_action :set_pedido, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :puede_ver_web
    before_action :puede_crear_visita, only: [:create]
    before_action :puede_editar_visita, only: [:update]
    before_action :puede_borrar_visita, only: [:destroy]

    def index
        @filterrific = initialize_filterrific(
          Pedido,
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
        @pedidos = @filterrific.find.includes(:person).activos.page(params[:page])

        # Respond to html for initial page load and to js for AJAX filter updates.
        respond_to do |format|
          format.html
          format.js
          format.xlsx
        end
    end

    def new
        @pedido = Pedido.new
        @pedido.fecha = Time.now.ago(1.days)
    end

  def edit
  end

  def create
    @pedido = Pedido.new(pedido_params)
    @pedido.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @pedido.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::PEDIDO, @pedido
        format.html { redirect_to pedidos_url, notice: 'Pedido creado correctamente.' }
        format.json { render :show, status: :created, location: @pedido }
        format.js { render :show, status: :created, location: @pedido }
      else
        format.html { render :new }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
        format.js   { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pedido.update(pedido_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::PEDIDO, @pedido
        format.html { redirect_to pedidos_url, notice: 'Pedido actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @pedido }
        format.js { render :show, status: :created, location: @pedido }
      else
        params[:person_id] = @pedido.person_id
        format.html { render :edit }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
        format.js   { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    PedidoDataAccess.borrar_logico(@pedido, current_user)
    respond_to do |format|
      format.html { redirect_to pedidos_url(:person_id => params[:person_id]), notice: 'Pedido borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      params.require(:pedido).permit(:descripcion, :fecha, :person_id, :completado)
    end
end
