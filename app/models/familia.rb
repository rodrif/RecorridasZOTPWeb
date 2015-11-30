class Familia < ActiveRecord::Base
  belongs_to :area
  belongs_to :zone
  belongs_to :ranchada

  validates :nombre, presence: true,
    format: { with: /\A[a-zA-Z\sáéíóúÁÉÍÓÚ]+\z/, message: I18n.t('common.errores.solo_letras') }

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
    "(LOWER(familias.nombre) LIKE ?)"
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
end
