class Evento < ActiveRecord::Base
  belongs_to :person
  belongs_to :user
  has_one :notificacion, dependent: :destroy

  validates :titulo, :fecha_desde, :fecha_hasta, presence: true
  validate :fecha_valida

  private

  def fecha_valida
    if fecha_desde.past?
      errors.add(:fecha_desde, "no puede ser anterior a la hora actual")
    end

    if fecha_hasta < fecha_desde
      errors.add(:fecha_hasta, "no puede ser anterior a la hora de inicio")
    end
  end
end
