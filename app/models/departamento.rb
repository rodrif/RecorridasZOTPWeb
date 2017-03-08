class Departamento < ActiveRecord::Base
    belongs_to :state
    has_and_belongs_to_many :people

    scope :activos, -> { where.not(state_id: 3).order(:nombre) }

    def getDescripcionAuditoria
        return "Nombre: #{nombre}"
    end
end
