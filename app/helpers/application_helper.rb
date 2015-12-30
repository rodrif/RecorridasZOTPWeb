module ApplicationHelper

  def showNotice
    if notice
      "<p id=\"notice\" class=\"alert alert-success\">#{ notice }</p>".html_safe
    end
  end

  def loadDefaultDropdowns entity = nil
    @zonas = Zone.zonas_primer_area
    @ranchadas = Ranchada.where(:zone_id => @zonas.first.id)
    if (entity && @zonas.first)
      entity.area_id = @zonas.first.area_id
    end    
  end
end
