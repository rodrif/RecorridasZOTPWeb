class Person < ActiveRecord::Base
  validates :nombre, presence: true

  belongs_to :zone
  belongs_to :state
  has_many :visits

end
