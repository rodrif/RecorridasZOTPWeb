class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  extend ModelHelper
  after_validation :ensure_uid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable #, :validatable por doble validacion

  validates :telefono, allow_blank: true, numericality: { only_integer: true }

  belongs_to :rol
  belongs_to :area
  belongs_to :state
  has_many :auditorias

  self.per_page = 20

  filterrific(
    available_filters: [
      :search_query,
      :with_area_id,
      :voluntarios_activos
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
        "(LOWER(users.name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_area_id, lambda { |area_id|
    where("area_id = ?", area_id)
  }

  scope :activos, -> { where.not(state_id: 3).order(:name) }

  scope :voluntarios_activos, lambda { |reference_time = nil|
    if reference_time.blank?
      where.not(state_id: 3).includes(:auditorias).group(:user, :id).order(:name)
    else
      joins(:auditorias).where('fecha >= ?', reference_time).group("auditorias.id").order(:name)
    end
  }

  def ensure_uid
    if self.uid.blank?
      self.uid = self.email
    end
  end

  def getDescripcionAuditoria
    return "Nombre: #{name} Apellido: #{apellido} Área: #{area.nombre} Rol: #{rol.nombre} Email: #{email}"
  end

end

