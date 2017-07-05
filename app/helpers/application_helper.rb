module ApplicationHelper

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

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

end
