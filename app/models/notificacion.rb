class Notificacion < ActiveRecord::Base
  belongs_to :frecuencia_tipo
  belongs_to :state
  has_many :notificacion_roles
  has_many :roles, :through => :notificacion_roles # should be has_and_belongs_to_many
  has_and_belongs_to_many :areas
  accepts_nested_attributes_for :notificacion_roles, allow_destroy: true
  validates :titulo, :subtitulo, :fecha_desde, :frecuencia_tipo_id, :presence => true
  validates :fecha_hasta, :presence => true, :unless => "frecuencia_tipo_id == 1"
  validates :frecuencia_cant, :presence => true, :unless => "frecuencia_tipo_id == 1"
  validates :frecuencia_cant, allow_blank: true, numericality: { greater_than: 0, only_integer: true }
  validates :areas, :presence => true
  validate :fecha_desde_mayor_fecha_hasta
  validate :fecha_desde_en_el_pasado, on: :create
  validate :sin_roles

  def sin_roles
    if !notificacion_roles.any?
      errors.add(:roles, "no puede estar en blanco")
    end
  end

  def necesitaCalcularProxEnvio notificacion_params
    if (notificacion_params['fecha_desde'] != self.fecha_desde)
      return true
    end
    if (self.frecuencia_tipo.code != FrecuenciaTipo::UNICA && notificacion_params['fecha_hasta'] != self.fecha_hasta)
      return true
    end
    if (notificacion_params['frecuencia_tipo_id'].to_i != self.frecuencia_tipo_id)
      return true
    end
    if (self.frecuencia_tipo.code != FrecuenciaTipo::UNICA)
      if (notificacion_params['frecuencia_cant'].to_i != self.frecuencia_cant)
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def fecha_desde_en_el_pasado
    if (fecha_desde + 1.hour).past?
      errors.add(:fecha_desde, "no puede estar en el pasado")
    end
  end

  def fecha_desde_mayor_fecha_hasta
    if frecuencia_tipo_id != 1 && fecha_hasta.comparable_time < fecha_desde.comparable_time
      errors.add(:fecha_hasta, "no puede ser anterior a fecha desde")
    end
  end

  def calcularProxEnvio
    if self.frecuencia_tipo_id != FrecuenciaTipo::UNICA
      case self.frecuencia_tipo_id
      when FrecuenciaTipo::DIA
        prox = self.prox_envio.advance(days: frecuencia_cant)
      when FrecuenciaTipo::SEMANA
        prox = self.prox_envio.advance(weeks: frecuencia_cant)
      when FrecuenciaTipo::MES
        prox = self.prox_envio.advance(months: frecuencia_cant)
      else
        prox = self.fecha_hasta # para que quede finalizada
      end
      if prox.comparable_time < self.fecha_hasta.comparable_time
        self.prox_envio = prox
      else
        self.finalizada = true
      end
    else
      self.finalizada = true
    end
    if self.prox_envio.past? && !self.finalizada
      self.calcularProxEnvio
    end
  end

  def sacar_minutos
    self.fecha_desde = self.fecha_desde.change(:min => 0)
    if self.fecha_hasta
      self.fecha_hasta = self.fecha_hasta.change(:min => 0)
    end
  end

  filterrific(
    available_filters: [
      :with_titulo,
      :fecha_gte,
      :fecha_lte,
      :with_tipo
    ]
  )

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
      "(LOWER(notificaciones.titulo) LIKE ?)"
    }.join(' AND '),
    *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :activas, -> { where.not(state_id: 3).order(fecha_desde: :desc) }

  def frecuencia
    "#{frecuencia_cant if frecuencia_tipo_id != 1} #{frecuencia_tipo.nombre}"
  end

  def getDescripcionAuditoria
    return "Título: #{titulo} Subtítulo: #{titulo} Fecha desde: #{fecha_desde} Fecha hasta: #{fecha_hasta} Prox envio: #{prox_envio} Descripción: #{descripcion} Frecuencia #{frecuencia}"
  end

  def tiene_rol?(rol_id)
    roles.any? { |r| r.id == rol_id } || notificacion_roles.any? { |nr| self.id == nr.notificacion_id && nr.rol_id == rol_id }
  end

  def setup_roles!
    Rol.activos.each { |rol|
      notificacion_roles.build(rol: rol) unless tiene_rol?(rol.id)
    }
  end
end
