require 'aws/ses'
include SqsHelper

module DesignsHelper
    def self.convert_pending_designs 
        message_from_queue = obtain_message_from_queue[0]
        if message_from_queue
			design = Design.find_by_id(message_from_queue.body)
            if design
                design.pictureProcessed = design.pictureOriginal 
                enviarCorreo(design.email)
                design.state = "Disponible"
                design.save
                delete_message_from_queue(message_from_queue.receipt_handle)
            end
        else
            print "sleeping"
            sleep(1.minutes)
        end
    end
        
    def self.enviarCorreo(email)
        ses = AWS::SES::Base.new(
            :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
            :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
#            :server => 'email.eu-west-1.amazonaws.com'
            )
        ses.send_email(
             :to        => 'test.ruby.cloud@gmail.com',#[email], un verified mails!!!
             :source    => '"Designmatch" <test.ruby.cloud@gmail.com>',
             :subject   => 'Imagen exitosamente convertida',
             :text_body => 'Tu imagen ha sido recibida y convertida exitosamente'
        )  # Llamamos al   ActionMailer que creamos
    #    ActionCorreo.bienvenido_email(email).deliver_now
    end
end
