class InstitucionDataAccess

  def self.borrar_logico institucion, user
    institucion.state_id = 3
    if user
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::INSTITUCION, institucion
    end
    institucion.save(validate: false)
  end

end
