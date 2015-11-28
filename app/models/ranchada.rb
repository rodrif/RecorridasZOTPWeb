class Ranchada < ActiveRecord::Base
  belongs_to :area
  belongs_to :zone

  validates :nombre, presence: true,
    format: { with: /\A[a-zA-Z\sáéíóúÁÉÍÓÚ]+\z/, message: I18n.t('common.errores.solo_letras') }
end
