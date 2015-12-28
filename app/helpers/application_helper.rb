module ApplicationHelper

  def showNotice
    if notice
      "<p id=\"notice\" class=\"alert alert-success\">#{ notice }</p>".html_safe
    end
  end

  def loadDefaultDropdowns
    @zonas = Zone.zonas_primer_area
    @ranchadas = Ranchada.where(:zone_id => @zonas.first.id)      
  end
end
