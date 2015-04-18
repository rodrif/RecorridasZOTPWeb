class Person < ActiveRecord::Base
  validates :nombre, presence: true

  belongs_to :zone


end
