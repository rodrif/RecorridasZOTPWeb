class InformesController < ApplicationController
  # include ApplicationHelper
  before_action :puede_ver_informes

  def index
  end

  def voluntarios
    @filterrific = initialize_filterrific(
      User,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select
      },
      :default_filter_params => {voluntarios_activos: 1.month.ago.strftime("%d/%m/%Y")},
      persistence_id: false
    ) or return
    if request.format.xlsx?
      @voluntarios = @filterrific.find.includes(:area).includes(:rol).includes(:jornadas)
    else
      @voluntarios = @filterrific.find.includes(:area).includes(:rol).includes(:jornadas).page(params[:page])
    end
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end

  def personas
    @filterrific = initialize_filterrific(
      Person,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select,
        with_zone_id: Zone.options_for_select
      },
      :default_filter_params => {personas_activas: 3.month.ago.strftime("%d/%m/%Y")},
      persistence_id: false
    ) or return
    if request.format.xlsx? || request.format.docx?
      @personas = @filterrific.find.includes(zone: [:area])
    else
      @personas = @filterrific.find.includes(zone: [:area]).page(params[:page])
    end
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.docx
      format.html
      format.js
      format.xlsx
    end
  end

  def cumpleanios
    @filterrific = initialize_filterrific(
      Person,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select,
        with_zone_id: Zone.options_for_select
      },
      :default_filter_params => {personas_activas: 3.month.ago.strftime("%d/%m/%Y")},
      persistence_id: false
    ) or return
    if request.format.xlsx?
      @personas = @filterrific.find.includes(zone: [:area])
    else
      @personas = @filterrific.find.includes(zone: [:area]).page(params[:page])
    end
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end

  def visitas
    @filterrific = initialize_filterrific(
      Visit,
      params[:filterrific],
      select_options: {
        visitas: Area.options_for_select,
      },
      :default_filter_params => {fecha_gte: 3.month.ago.strftime("%d/%m/%Y")},
      persistence_id: false
    ) or return
    if request.format.xlsx?
      @visitas = @filterrific.find.visitas
    else
      @visitas = @filterrific.find.visitas.page(params[:page])
    end
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end

end
