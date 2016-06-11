class Ranchada < ActiveRecord::Base
  attr_accessor :area_id
  extend ModelHelper
  belongs_to :area
  belongs_to :zone
  belongs_to :state

  validates :nombre, presence: true,
    format: { with: getRexExpSoloLetras, message: I18n.t('common.errores.solo_letras') }
  validates :zone, presence: true

  self.per_page = 20

  filterrific(
    available_filters: [
      :search_query,    
      :with_zone_id,
      :with_area_id
    ]
  )

  scope :search_query, lambda { |query|
  return nil  if query.blank?

  # condition query, parse into individual keywords
  terms = query.downcase.split(/\s+/)

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
    "(LOWER(ranchadas.nombre) LIKE ?)"
  }.join(' AND '),
  *terms.map { |e| [e] * num_or_conds }.flatten
  )
  }

  scope :with_zone_id, lambda { |zone_ids|
  where(zone_id: [*zone_ids])
  }

  scope :with_area_id, lambda { |area_id|
  joins(zone: :area).where("areas.id = ?", area_id)
  }

  scope :activas, -> { where.not(state_id: 3).order(:nombre) }

  def getDescripcionAuditoria
    return "Nombre: #{nombre} Área: #{zone.area.nombre} Zona: #{zone.nombre} Descripción: #{descripcion}"
  end

end
