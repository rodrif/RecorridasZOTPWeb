class FamiliaDataAccess

  def self.actualizar_dependencias_ranchada ranchada
      familias = Familia.where(:ranchada_id => ranchada.id)
      Person.transaction do
        familias.each do |f|
          f.zone_id = ranchada.zone_id
          f.save
        end
      end
  end

  def self.borrar_logico familia
    familia.state_id = 3
    familia.zone_id = nil
    familia.ranchada_id = nil
    familia.save(validate: false)
  end

end