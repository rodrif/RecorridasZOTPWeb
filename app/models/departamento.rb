class Departamento < ApplicationRecord
    belongs_to :state
    has_and_belongs_to_many :people

    scope :activos, -> { where.not(state_id: 3).order(:nombre) }

    def self.options_for_select
        activos.order('LOWER(nombre)').map { |e| [e.nombre, e.id] }
    end

    def getDescripcionAuditoria
        return "Nombre: #{nombre}"
    end
end
