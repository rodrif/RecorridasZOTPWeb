class Person < ActiveRecord::Base
  validates :nombre, presence: true

  belongs_to :zone
  belongs_to :state
  has_many :visits

  self.per_page = 5

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
	where(
	terms.map { |term|
	  "(LOWER(people.nombre) LIKE ?)"
	}.join(' AND '),
	*terms.map { |e| [e] * num_or_conds }.flatten
	)
  }

  scope :with_zone_id, lambda { |zone_ids|
	where(zone_id: [*zone_ids])
  }
end
