class Person < ActiveRecord::Base
  attr_accessor :area_id
  extend ModelHelper

  validates :nombre, presence: true,
    format: { with: getRexExpSoloLetras, message: I18n.t('common.errores.solo_letras') }
  validates :apellido, allow_blank: true,
    format: { with: getRexExpSoloLetras, message: I18n.t('common.errores.solo_letras') }
  validates :dni, allow_blank: true, numericality: { only_integer: true }
  validates :telefono, allow_blank: true, numericality: { only_integer: true }
  validates :zone, presence: true

  belongs_to :zone
  belongs_to :state
  belongs_to :estado
  belongs_to :institucion
  has_many :visits, -> {order(fecha: :desc, id: :desc)}, :dependent => :delete_all
  has_many :pedidos, -> {order(fecha: :desc)}, :dependent => :delete_all
  accepts_nested_attributes_for :visits
  has_and_belongs_to_many :departamentos

  self.per_page = 20

  filterrific(
    available_filters: [
      :search_query,
      :with_zone_id,
      :with_area_id,
      :with_estado_id,
      :with_departamento_id,
      :with_institucion_id,
      :personas_activas
    ]
  )

  def cumple_en dias = 0
    return self.state_id != 3 && self.fecha_nacimiento && self.fecha_nacimiento.strftime('%e %b') == Time.now.utc.advance(days: dias).strftime('%e %b')
  end

  scope :getCumpleanios, -> (dias = 0) { where.not(state_id: 3).select {|p| p.cumple_en(dias)} }

  def full_name
    "#{nombre} #{apellido}"
  end

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
	  "(LOWER(people.nombre) LIKE ?)"
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

  scope :with_estado_id, lambda { |estado_ids|
    where(estado_id: [*estado_ids])
  }

  scope :with_institucion_id, lambda { |institucion_ids|
	  where(institucion_id: [*institucion_ids])
  }

  scope :with_departamento_id, lambda { |departamento_ids|
    return nil if departamento_ids.all? { |item| item.blank? }
    joins(:departamentos).where(departamentos: {id: [*departamento_ids]}).uniq
  }

  scope :activas, -> { where.not(state_id: 3).order(:nombre, :apellido) }

  scope :personas_activas, lambda { |reference_time|
    return nil if reference_time.blank?
    where.not(state_id: 3).joins(:visits).where('fecha >= ?', reference_time.to_datetime.in_time_zone('Moscow').to_s).group("people.id").order(:nombre)
  }

  def getDescripcionAuditoria
    return "Nombre: #{nombre} Apellido: #{apellido} Sede: #{zone.area.nombre if !zone.nil?} Zona: #{zone.nombre if !zone.nil?}"
  end

end
