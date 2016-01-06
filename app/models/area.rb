class Area < ActiveRecord::Base
  validates :nombre, presence: true, uniqueness: { case_sensitive: false },
    format: { with: /\A[a-zA-Z\sáéíóúÁÉÍÓÚ]+\z/, message: I18n.t('common.errores.solo_letras') }
 
  belongs_to :state

  self.per_page = 20

  filterrific(
    available_filters: [
      :search_query
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
    "(LOWER(areas.nombre) LIKE ?)"
  }.join(' AND '),
  *terms.map { |e| [e] * num_or_conds }.flatten
  )
  }

	def self.options_for_select
  		order('LOWER(nombre)').map { |e| [e.nombre, e.id] }
	end

  scope :activas, -> { where.not(state_id: 3).order(:nombre) }
	
end
