class Visit < ActiveRecord::Base
  belongs_to :person
  belongs_to :state

  self.per_page = 20

  filterrific(
    available_filters: [
      :search_query,    
      :with_zone_id
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

	joins(:person).where(
	terms.map { |term|
	  "(LOWER(people.nombre) LIKE ?)"
	}.join(' AND '),
	*terms.map { |e| [e] * num_or_conds }.flatten
	)
  }

   scope :with_zone_id, lambda { |zone_ids|
	joins(:person).where("people.zone_id = ?", zone_ids)
  }
end
