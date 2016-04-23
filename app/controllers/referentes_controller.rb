class ReferentesController < ApplicationController
  before_action :set_referente, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web

  # GET /referentes
  # GET /referentes.json
  def index
    @filterrific = initialize_filterrific(
      Referente,
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
    @referentes = @filterrific.find.activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /referentes/1
  # GET /referentes/1.json
  def show
  end

  # GET /referentes/new
  def new
    @referente = Referente.new
  end

  # GET /referentes/1/edit
  def edit
  end

  # POST /referentes
  # POST /referentes.json
  def create
    @referente = Referente.new(referente_params)
    @referente.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @referente.save
        format.html { redirect_to referentes_url, notice: 'Referente creado correctamente.' }
        format.json { render :show, status: :created, location: @referente }
      else
        format.html { render :new }
        format.json { render json: @referente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referentes/1
  # PATCH/PUT /referentes/1.json
  def update
    respond_to do |format|
      if @referente.update(referente_params)
        format.html { redirect_to referentes_url, notice: 'Referente actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @referente }
      else
        format.html { render :edit }
        format.json { render json: @referente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referentes/1
  # DELETE /referentes/1.json
  def destroy
    ReferenteDataAccess.borrar_logico(@referente)
    respond_to do |format|
      format.html { redirect_to referentes_url, notice: 'Referente borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referente
      @referente = Referente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referente_params
      params.require(:referente).permit(:nombre, :apellido, :telefono, :area_id, :dia)
    end
end
