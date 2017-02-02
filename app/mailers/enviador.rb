class Enviador < ApplicationMailer

    def version_android_deprecada(user)
        @user = user
        mail(to: 'diegopintos81@gmail.com', subject: 'Un usuario necesita actualizar la app')
    end

end
