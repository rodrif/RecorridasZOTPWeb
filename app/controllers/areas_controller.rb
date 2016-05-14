class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web

  # GET /areas
  # GET /areas.json
  def index
    @filterrific = initialize_filterrific(
      Area,
      params[:filterrific],
      select_options: {},
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @areas = @filterrific.find.activas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)
    @area.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @area.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::AREA, @area.id
        format.html { redirect_to areas_url, notice: 'Area creada correctamente.' }
        format.json { render :show, status: :created, location: @area }
        format.js { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
        format.js   { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::AREA, @area.id
        format.html { redirect_to areas_url, notice: 'Area actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    AreaDataAccess.borrar_logico(@area)
    AuditoriaDataAccess.log current_user, Auditoria::BAJA, Auditoria::AREA, @area.id
    respond_to do |format|
      format.html { redirect_to areas_url, notice: 'Area borrada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:nombre)
    end
end
