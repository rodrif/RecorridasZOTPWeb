class Institucion < ActiveRecord::Base
  belongs_to :state
  belongs_to :zone
	belongs_to :institucion_tipo

  filterrific(
    available_filters: [
      :search_query
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
	  "(LOWER(instituciones.nombre) LIKE ?)"
	}.join(' AND '),
	*terms.map { |e| [e] * num_or_conds }.flatten
	)
  }

  scope :activas, -> { where.not(state_id: 3).order(:nombre) }

  def getDescripcionAuditoria
    return "Nombre: #{nombre} Descripción: #{descripcion} Dirección: #{direccion}"
  end

end
