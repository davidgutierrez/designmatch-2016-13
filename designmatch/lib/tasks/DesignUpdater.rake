desc 'update In Process'
    task updateInProcess: :environment do 
        
        design = Design.where(state: "En proceso").last
        if(design != nil)
            design.pictureProcessed = design.pictureOriginal 
            enviarCorreo(design.email)
            design.state = "Disponible"
            design.save
        end
    end
   
    def enviarCorreo(email)
        ses = AWS::SES::Base.new(
            :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
            :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
#            :server => 'email.eu-west-1.amazonaws.com'
            )
        ses.send_email(
             :to        => [email],
             :source    => '"Designmatch" <test.ruby.cloud@gmail.com>',
             :subject   => 'Imagen exitosamente convertida',
             :text_body => 'Tu imagen ha sido recibida y convertida exitosamente'
        )  # Llamamos al   ActionMailer que creamos
    #    ActionCorreo.bienvenido_email(email).deliver_now
    end
