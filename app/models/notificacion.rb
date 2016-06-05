class Notificacion < ActiveRecord::Base
  belongs_to :frecuencia_tipo
  belongs_to :notificacion_tipo
  belongs_to :state
  has_many :notificacion_roles
  has_many :roles, :through => :notificacion_roles
  accepts_nested_attributes_for :notificacion_roles, allow_destroy: true

  filterrific(
    available_filters: [
      :with_titulo,
      :fecha_gte,
      :fecha_lte,
      :with_tipo
    ]
  )

  scope :with_tipo, lambda { |tipo|
    where(notificacion_tipo: tipo)
  }

  scope :fecha_gte, lambda { |reference_time|
    return nil if reference_time.blank?
    where('fecha_desde >= ?', reference_time.to_datetime.in_time_zone('Moscow').to_s)
  }

  scope :fecha_lte, lambda { |reference_time|
    return nil if reference_time.blank?
    where('fecha_desde <= ?', reference_time.to_datetime.in_time_zone('Moscow').to_s)
  }

  scope :with_titulo, lambda { |query|
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
      "(LOWER(notificaciones.titulo) LIKE ?)"
    }.join(' AND '),
    *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :activas, -> { where.not(state_id: 3).order(fecha_desde: :desc) }

  def frecuencia
    "#{frecuencia_cant} #{frecuencia_tipo.nombre if !frecuencia_tipo.nil?}"
  end

  def getDescripcionAuditoria
    return "Título: #{titulo} Subtítulo: #{titulo} Tipo: #{notificacion_tipo.nombre if !notificacion_tipo.nil?} Fecha desde: #{fecha_desde} Fecha hasta: #{fecha_hasta} Descripción: #{descripcion} Frecuencia #{frecuencia}"
  end

  def tiene_rol?(rol_id)
    roles.any? { |r| r.id == rol_id }
  end

  def setup_roles!
    Rol.activos.each { |rol|
      notificacion_roles.build(rol: rol) unless tiene_rol?(rol.id)
    }
  end
end
