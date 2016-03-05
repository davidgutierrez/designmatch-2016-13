desc 'update In Process'
    task updateInProcess: :environment do #
        Design.where(state: "En proceso").first do |design|
            design.pictureProcessed = design.pictureOriginal 
            enviarCorreo(design.email)
            design.state = "Disponible"
            design.save
        end
        
        Thread.new { GC.start }
    end
   
    def enviarCorreo(email)
    # Llamamos al   ActionMailer que creamos
        ActionCorreo.bienvenido_email(email).deliver_now
    end
