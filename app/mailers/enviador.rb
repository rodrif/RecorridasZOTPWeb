class Enviador < ApplicationMailer

    def version_android_deprecada(user)
        @user = user
        mail(to: 'diegopintos81@gmail.com', subject: 'Un usuario necesita actualizar la app')
    end

    def nuevo_voluntario_registrado(user, coordinador)
        @user = user
        @coordinador = coordinador
        mail(to: @coordinador.email, subject: 'Un voluntario se registró en la web')
    end

end
