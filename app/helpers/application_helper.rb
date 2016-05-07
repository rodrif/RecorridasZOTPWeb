module ApplicationHelper

  # def showNotice
  #   if notice
  #     return "<p id=\"notice\" class=\"alert alert-success\">#{ notice }</p>".html_safe
  #   end
  #   if alert
  #     return "<p id=\"alert\" class=\"alert alert-danger\">#{ alert }</p>".html_safe
  #   end
  #   # if info
  #   #   return "<p id=\"alert\" class=\"alert alert-info\">#{ info }</p>".html_safe
  #   # end
  #   # if defined?(error)
  #   #   return "<p id=\"alert\" class=\"alert alert-danger\">#{ error }</p>".html_safe
  #   # end
  # end

  def loadDefaultDropdowns entity = nil
    @zonas = Zone.zonas_primer_area
    @ranchadas = Ranchada.activas.where(:zone_id => @zonas.first.id)
    @familias = Familia.activas.where(:zone_id => @zonas.first.id)
    if (entity && @zonas.first)
      entity.area_id = @zonas.first.area_id
      entity.zone_id = @zonas.first.id
    end 
    if (entity && @familias.first && entity.has_attribute?('familia_id'))
      entity.familia_id = @familias.first.area_id
    end
  end

end
