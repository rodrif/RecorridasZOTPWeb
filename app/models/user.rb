class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  after_validation :ensure_uid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  belongs_to :rol
  belongs_to :area
  belongs_to :state

  self.per_page = 1

  filterrific(
    available_filters: [
      :search_query,
      :with_area_id
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

  def ensure_uid
    if self.uid.blank?
      self.uid = self.email
    end
  end
end

