class ActionCorreo < ApplicationMailer
    
    def bienvenido_email(email)
        @email = email
        #@url  = 'http://codeHero.co'
        mail(to: @email, subject: 'Correo de Prueba Ruby')
    end
    
    def enviarCorreo(email)
        ses = AWS::SES::Base.new(
            :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
            :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
            )
        ses.send_email(
             :to        => 'test.ruby.cloud@gmail.com',#[email], un verified mails!!!
             :source    => '"Designmatch" <test.ruby.cloud@gmail.com>',
             :subject   => 'Imagen exitosamente convertida',
             :text_body => 'Tu imagen ha sido recibida y convertida exitosamente'
        )
    end
end
