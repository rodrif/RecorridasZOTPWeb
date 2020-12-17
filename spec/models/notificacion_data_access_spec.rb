require "rails_helper"

RSpec.describe NotificacionDataAccess, :type => :model do
  context "proximo cumpleaños" do
    it "envia notificaciones de cumpleaños proximos de las personas" do
      NotificacionDataAccess.proxCumpleanios
    end
  end

  context "enviar cumpleaños" do
    it "envia notificaciones de cumpleaños de las personas" do
      NotificacionDataAccess.enviarCumpleanios
    end
  end

  context "enviar notificaciones" do
    it "envia notificaciones guardadas" do
      NotificacionDataAccess.enviarNotificaciones
    end
  end
end