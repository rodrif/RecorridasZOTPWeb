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

    def update_personas
        if params[:area_id].blank? && params[:zone_id].blank?
            @personas = Person.activas
        elsif params[:zone_id].blank?
            @personas = Person.joins(:zone).where("zones.area_id = ?", params[:area_id]).activas
        else
            @personas = Person.where("zone_id = ?", params[:zone_id]).activas
        end
        @selectorPersona = params[:selector_persona]
        respond_to do |format|
          format.js
        end
    end

    def update_pedidos_pendientes
        if params[:person_id].blank?
            @pedidos = nil
        else
            @pedidos = Pedido.where("person_id = ? AND completado = ?", params[:person_id], false).activos
        end
        respond_to do |format|
          format.html {render :layout => false}
        end
    end

    def edit_pedido_modal
        @pedido = Pedido.find(params[:id])
        respond_to do |format|
            format.js
        end
    end

end
