class RanchadasController < ApplicationController
  before_action :set_ranchada, only: [:show, :edit, :update, :destroy]

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
    @ranchadas = @filterrific.find.order(:nombre).page(params[:page])

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
    @zonas = Zone.where(:area_id => Area.first.id)
  end

  # GET /ranchadas/1/edit
  def edit
    @zonas = Zone.where(:area_id => @ranchada.zone.area.id)
  end

  # POST /ranchadas
  # POST /ranchadas.json
  def create
    @ranchada = Ranchada.new(ranchada_params)

    respond_to do |format|
      if @ranchada.save
        format.html { redirect_to ranchadas_url, notice: 'Ranchada creada correctamente.' }
        format.json { render :show, status: :created, location: @ranchada }
        format.js { render :show, status: :created, location: @ranchada }
      else
        if @ranchada.zone
          @zonas = Zone.where(:area_id => @ranchada.zone.area.id)
        else
          @zonas = Zone.where(:area_id => Area.first.id)
          @ranchada.area_id = @zonas.first.area.id
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
        format.html { redirect_to ranchadas_url, notice: 'Ranchada actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @ranchada }
      else
        if @ranchada.zone
          @zonas = Zone.where(:area_id => @ranchada.zone.area.id)
        else
          @zonas = Zone.where(:area_id => Area.first.id)
          @ranchada.area_id = @zonas.first.area.id
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
    @ranchada.destroy
    respond_to do |format|
      format.html { redirect_to ranchadas_url, notice: 'Ranchada borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranchada
      @ranchada = Ranchada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ranchada_params
      params.require(:ranchada).permit(:nombre, :area_id, :zone_id, :descripcion, :latitud, :longitud)
    end
end
