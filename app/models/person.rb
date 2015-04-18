class Person < ActiveRecord::Base
  validates :nombre, presence: true

  belongs_to :zone
  has_many :visits


end
