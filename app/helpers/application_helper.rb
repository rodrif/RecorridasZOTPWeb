module ApplicationHelper

  def loadDefaultDropdowns entity = nil
    @zonas = Zone.zonas_primer_area
    if (entity && @zonas.first)
      entity.area_id = @zonas.first.area_id
      entity.zone_id = @zonas.first.id
    end
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

end
