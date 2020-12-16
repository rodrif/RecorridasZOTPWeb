class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  extend ModelHelper
  after_validation :ensure_uid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable #, :validatable por doble validacion

  validates :telefono, allow_blank: true, numericality: { only_integer: true, message: I18n.t('common.errores.solo_numeros') }

  belongs_to :rol
  belongs_to :area
  belongs_to :state
  has_many :auditorias
  has_and_belongs_to_many :jornadas
  has_many :eventos

  self.per_page = 20

  filterrific(
    available_filters: [
      :search_query,
      :with_area_id,
      :voluntarios_activos,
      :with_email
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
        "(LOWER(users.name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_area_id, lambda { |area_id|
    where("area_id = ?", area_id)
  }

  scope :with_email, lambda { |email|
    where("email = ?", email)
  }

  scope :activos, -> { where.not(state_id: 3) }

  scope :coordinadores, lambda { |area_id|
    where.not(state_id: 3).where(rol_id: [1,2,3]).with_area_id(area_id)
  }

  scope :voluntarios_activos, lambda { |reference_time|
    return nil if reference_time.blank?
    where.not(state_id: 3).joins(:auditorias).where('fecha >= ?', reference_time.to_datetime.in_time_zone('Moscow').to_s).group("users.id").order(:name)
  }

  def ensure_uid
    if self.uid.blank?
      self.uid = self.email
    end
  end

  def getDescripcionAuditoria
    return "Nombre: #{name} Apellido: #{apellido} Sede: #{area.nombre} Rol: #{rol.nombre} Email: #{email}"
  end

end

