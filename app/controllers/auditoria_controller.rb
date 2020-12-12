class AuditoriaController < ApplicationController
  before_action :is_admin

  def index
    @filterrific = initialize_filterrific(
      Auditoria,
      params[:filterrific],
      select_options: {
        with_accion: [
          [Auditoria::ALTA, Auditoria::ALTA],
          [Auditoria::BAJA, Auditoria::BAJA],
          [Auditoria::MODIFICACION, Auditoria::MODIFICACION]
        ],
        with_entidad: [
          [Auditoria::AREA, Auditoria::AREA],
          [Auditoria::ESTADO, Auditoria::ESTADO],
          [Auditoria::PERSONA, Auditoria::PERSONA],
          [Auditoria::DEPARTAMENTO, Auditoria::DEPARTAMENTO],
          [Auditoria::VISITA, Auditoria::VISITA],
          [Auditoria::ZONA, Auditoria::ZONA]
        ]
      },
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @auditorias = @filterrific.find.ordenadas.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

end
