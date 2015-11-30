class Referente < ActiveRecord::Base
  belongs_to :area

  validates :nombre, presence: true,
    format: { with: /\A[a-zA-Z\sáéíóúÁÉÍÓÚ]+\z/, message: I18n.t('common.errores.solo_letras') }
  validates :apellido, presence: true,
    format: { with: /\A[a-zA-Z\sáéíóúÁÉÍÓÚ]+\z/, message: I18n.t('common.errores.solo_letras') }
  validates :telefono, allow_blank: true, numericality: { only_integer: true }

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
    "(LOWER(referentes.nombre) LIKE ?)"
  }.join(' AND '),
  *terms.map { |e| [e] * num_or_conds }.flatten
  )
  }

  scope :with_area_id, lambda { |area_id|
    where("area_id = ?", area_id)
  }
end
