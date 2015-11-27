class Zone < ActiveRecord::Base
	belongs_to :area

  validates :nombre, presence: true,
    format: { with: /\A[a-zA-Z]+\z/, message: I18n.t('common.errores.solo_letras') }

	def self.options_for_select
  		order('LOWER(nombre)').map { |e| [e.nombre, e.id] }
	end
end
