require 'aws/ses'
include SqsHelper

module DesignsHelper
    def all_converted_designs_in_competition(proyect)
        @designs = Design.where(:proyect_id=> proyect).all
		#@videos= Video.where(["competition_id = ? and converted_at IS NOT NULL", @competition]).order('created_at DESC').paginate(:page => params[:page], :per_page => 2);
    end
	
    def self.convert_pending_designs 
        message_from_queue = obtain_message_from_queue[0]
        if message_from_queue
			design = Design.find_by_id(message_from_queue.body)
            if design
            print "converDesign"
                convertDesign(design) 
  # Llamamos al   ActionMailer que creamos
            print "sending mail"
                ActionCorreo.bienvenido_email(design.email).deliver_now
            print "changing state"
                design.state = "Disponible"
            print "saving"
                design.save
            print "deletemessage"
                delete_message_from_queue(message_from_queue.receipt_handle)
            print "end"
            end
        else
            print "sleeping"
            sleep(1.minutes)
        end
    end
        

    def self.convertDesign(design) 
        image_data = design.pictureOriginal
        @text = '"'+design.created_at.strftime('%d-%m-%Y')+'"'
        image = MiniMagick::Image.open(image_data)
        image.path #=> "/var/folders/k7/6zx6dx6x7ys3rv3srh0nyfj00000gn/T/magick20140921-75881-1yho3zc.jpg"
        image.resize "800x600"
        image.format "png"do |c|
          c.gravity 'Center'
          c.stroke 'black'
          c.pointsize '22'
          c.draw 'text 0,-25 "'+design.firstName+'"'
          c.draw 'text 0,0 "'+design.lastName+'"'
          c.draw "text 0,25 "+@text
          c.fill 'white'
        end
        key = "uploads/pictureProcessed/"+design.consecutivo+"/image.png"
        AWS::S3.new.buckets[ENV['AWS_FOG_DIRECTORY']].objects[key].write(image.to_blob)
    end
end
