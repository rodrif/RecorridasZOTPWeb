class FamiliaDataAccess

  def self.actualizar_dependencias_ranchada ranchada
      familias = Familia.where(:ranchada_id => ranchada.id)
      Person.transaction do
        familias.each do |f|
          f.zone_id = ranchada.id
          f.save
        end
      end
  end

end