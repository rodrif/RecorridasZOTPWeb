module ModelHelper

  def getRexExpSoloLetras
    return /\A[a-zA-ZñÑÜü\sáéíóúÁÉÍÓÚ]+\z/
  end

  def getRexExpSoloLetrasYNumeros
    return /\A[a-zA-Z0-9ñÑÜü\sáéíóúÁÉÍÓÚ]+\z/
  end

end