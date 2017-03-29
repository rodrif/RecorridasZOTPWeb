class RolDataAccess

  def self.puede_crear_persona current_user = nil
    # admin, referente, coordinador, voluntario
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3 || current_user.rol_id == 4)
  end

  def self.puede_editar_persona current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_borrar_persona current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_ver_telefono_persona current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_crear_visita current_user = nil
    # admin, referente, coordinador, voluntario
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3 || current_user.rol_id == 4)
  end

  def self.puede_editar_visita current_user = nil
    # admin, referente, coordinador, voluntario
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3 || current_user.rol_id == 4)
  end

  def self.puede_borrar_visita current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_ver_web current_user = nil
    # admin, referente, coordinador, voluntario
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3 || current_user.rol_id == 4)
  end

  def self.puede_editar_area current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_editar_zona current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_editar_ranchada current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_editar_familia current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_ver_departamento current_user = nil
    # admin, referente, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 2 || current_user.rol_id == 3)
  end

  def self.puede_editar_departamento current_user = nil
    return current_user && current_user.rol_id == 1
  end

  def self.puede_ver_estado current_user = nil
    # admin, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 3)
  end

  def self.puede_editar_estado current_user = nil
    # admin, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 3)
  end

  def self.puede_editar_usuarios current_user = nil
    # admin, coordinador
    return current_user && (current_user.rol_id == 1 || current_user.rol_id == 3)
  end

  def self.is_admin current_user = nil
    return current_user && current_user.rol_id == 1
  end

end
