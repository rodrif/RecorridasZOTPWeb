class NotificacionRol < ActiveRecord::Base
  belongs_to :notificacion
  belongs_to :rol
end
