class Zone < ApplicationRecord
  extend ModelHelper
  belongs_to :area
  belongs_to :state

  validates :nombre, presence: true, uniqueness: { case_sensitive: false },
    format: { with: getRexExpSoloLetrasYNumeros, message: I18n.t('common.errores.solo_alfanumerico') }

  self.per_page = 20

  filterrific(
    available_filters: [
      :search_query,
      :with_area_id
    ]
  )

  scope :search_query, lambda { |query|
  return nil  if query.blank?

  # condition query, parse into individual keywords
  terms = query.to_s.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  terms = terms.map { |e|
  (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 1

  where(
  terms.map { |term|
    "(LOWER(zones.nombre) LIKE ?)"
  }.join(' AND '),
  *terms.map { |e| [e] * num_or_conds }.flatten
  )
  }

  scope :with_area_id, lambda { |area_id|
    where("area_id = ?", area_id)
  }

	def self.options_for_select
    activas.order('LOWER(nombre)').map { |e| [e.nombre, e.id] }
	end

  def self.zonas_primer_area
    zonas = Zone.activas.where(:area_id => Area.first.id)
    if zonas.length == 0
      zonas.push(Zone.new(nombre: 'Ninguna', id: 0))
    end
    zonas
  end

  scope :activas, -> { where.not(state_id: 3).order(:nombre) }

  def getDescripcionAuditoria
    return "Nombre: #{nombre} Sede: #{area.nombre if !area.nil?}"
  end

end
