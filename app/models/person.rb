class Person < ActiveRecord::Base
  validates :nombre, presence: true

  belongs_to :zone
  belongs_to :state
  has_many :visits

  filterrific(
    available_filters: [
      :with_zone_id
    ]
  )

  scope :with_zone_id, lambda { |zone_ids|
	where(zone_id: [*zone_ids])
  }
end
