class Estado < ActiveRecord::Base
  belongs_to :state
  scope :activos, -> { where.not(state_id: 3).order(:nombre) }

    def getDescripcionAuditoria
        return "Nombre: #{nombre}"
    end
end
