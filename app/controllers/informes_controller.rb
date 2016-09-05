class InformesController < ApplicationController
  # include ApplicationHelper
  # before_action :set_ranchada, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin

  def index
  end

  def voluntarios
    @filterrific = initialize_filterrific(
      User,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select
      },
      :default_filter_params => {voluntarios_activos: 1.month.ago.to_date.to_s},
      persistence_id: false
    ) or return
    @voluntarios = @filterrific.find
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
      :default_filter_params => {personas_activas: 3.month.ago.to_date.to_s},
      persistence_id: false
    ) or return
    @personas = @filterrific.find
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
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
      :default_filter_params => {personas_activas: 3.month.ago.to_date.to_s},
      persistence_id: false
    ) or return
    @personas = @filterrific.find
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end

  def visitas
    @filterrific = initialize_filterrific(
      Auditoria,
      params[:filterrific],
      select_options: {
        visitas: Area.options_for_select,
      },
      :default_filter_params => {fecha_gte: 3.month.ago.to_date.to_s},
      persistence_id: false
    ) or return
    @visitas = @filterrific.find.visitas
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end

end
