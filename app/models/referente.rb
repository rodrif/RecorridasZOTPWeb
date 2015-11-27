class Referente < ActiveRecord::Base
  belongs_to :area

  validates :nombre, presence: true,
    format: { with: /\A[a-zA-Z]+\z/, message: I18n.t('common.errores.solo_letras') }
  validates :telefono, allow_blank: true, numericality: { only_integer: true }
end
