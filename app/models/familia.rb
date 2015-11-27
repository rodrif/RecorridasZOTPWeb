class Familia < ActiveRecord::Base
  belongs_to :area
  belongs_to :zone
  belongs_to :ranchada

  validates :nombre, presence: true,
    format: { with: /\A[a-zA-Z]+\z/, message: I18n.t('common.errores.solo_letras') }

end
