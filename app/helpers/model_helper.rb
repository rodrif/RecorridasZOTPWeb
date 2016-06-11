module ModelHelper
    def getRexExpSoloLetras
      return /\A[a-zA-ZñÑÜü\sáéíóúÁÉÍÓÚ]+\z/
    end
end