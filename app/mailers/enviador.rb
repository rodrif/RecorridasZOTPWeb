class Enviador < ApplicationMailer

    def version_android_deprecada(user)
        @user = user
        mail(to: 'rodrif89@gmail.com', subject: 'Version de la app android deprecada')
    end

end
