class Evento < ActiveRecord::Base
  belongs_to :person
  belongs_to :user
  has_one :notificacion, dependent: :destroy
end
