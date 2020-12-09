class Estado < ApplicationRecord
  belongs_to :state
  validates :nombre, presence: true
  scope :activos, -> { where.not(state_id: 3).order(:nombre) }

    def self.options_for_select
        activos.order('LOWER(nombre)').map { |e| [e.nombre, e.id] }
    end

    def getDescripcionAuditoria
        return "Nombre: #{nombre}"
    end
end
