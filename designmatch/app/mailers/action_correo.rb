class ActionCorreo < ApplicationMailer
    
    def bienvenido_email(user)
        @user = user
        #@url  = 'http://codeHero.co'
        #mail(to: @user.email, subject: 'Correo de Prueba Ruby')
        mail(to: @user, subject: 'Correo de Prueba Ruby')
    end
    
end
