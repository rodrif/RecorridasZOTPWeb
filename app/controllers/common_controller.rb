class CommonController < ApplicationController

    def update_zonas_filter
        if params[:area_id].blank?
            @zonas = Zone.activas
        else
            @zonas = Zone.where("area_id = ?", params[:area_id])
        end
        @selectorZona = params[:selector_zona]
        respond_to do |format|
          format.js
        end
    end

end
