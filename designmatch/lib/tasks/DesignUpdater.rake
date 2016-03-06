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
    # Llamamos al   ActionMailer que creamos
        ActionCorreo.bienvenido_email(email).deliver_now
    end
