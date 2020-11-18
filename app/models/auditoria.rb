class Auditoria < ActiveRecord::Base
  belongs_to :user
  belongs_to :visit, :foreign_key => :entity_id

  ALTA = 'Alta'
  BAJA = 'Baja'
  MODIFICACION = 'Modificación'

  AREA = 'Sede'
  PERSONA = 'Persona'
  VISITA = 'Visita'
  ZONA = 'Zona'
  USUARIO = 'Usuario'
  NOTIFICACION = 'Notificación'
  PEDIDO = 'Pedido'
  DEPARTAMENTO = 'Departamento'
  ESTADO = 'Estado'
  INSTITUCION = 'Institucion'

  self.per_page = 20

  filterrific(
    available_filters: [
      :with_email,
      :with_accion,
      :with_entidad,
      :fecha_gte,
      :fecha_lte,
      :visitas
    ]
  )

  scope :fecha_gte, lambda { |reference_time|
    return nil if reference_time.blank?
    where('auditorias.fecha >= ?', reference_time.to_datetime.in_time_zone('Moscow').to_s)
  }

  scope :fecha_lte, lambda { |reference_time|
    return nil if reference_time.blank?
    where('fecha <= ?', reference_time.to_datetime.in_time_zone('Moscow').to_s)
  }

  scope :with_accion, lambda { |accion|
    where(accion: accion)
  }

  scope :with_entidad, lambda { |entidad|
    where(entidad: entidad)
  }

  scope :visitas, lambda { |area_id = nil|
    if area_id.blank?
      with_entidad(Auditoria::VISITA).joins(visit: [person: [{zone: :area}]]).group("zones.id", "areas.id").select("zones.nombre as zona_nombre", "areas.nombre as area_nombre", "COUNT(DISTINCT visits.id) as count")
    else
      with_entidad(Auditoria::VISITA).joins(visit: [person: [{zone: :area}]]).where("areas.id = ?", area_id).group("zones.id", "areas.id").select("zones.nombre as zona_nombre", "areas.nombre as area_nombre", "COUNT(DISTINCT visits.id) as count")
    end
  }

  scope :with_email, lambda { |query|
    return nil if query.blank?

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
        "(LOWER(auditorias.email) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :ordenadas, -> { order(id: :desc) }

end
