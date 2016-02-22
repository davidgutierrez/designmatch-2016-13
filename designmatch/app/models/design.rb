class Design < ActiveRecord::Base
   belongs_to :proyect
   after_initialize :init
   
   default_scope -> { order(created_at: :desc) }
   
   validates :proyect_id      , presence: true
   validates :email           , presence: true
   validates :firstName       , presence: true
   validates :lastName        , presence: true
   validates :offer           , presence: true
   validates :pictureOriginal , presence: true

   mount_uploader :pictureOriginal, PictureUploader   
   mount_uploader :pictureProcessed, PictureProcess
   
   def init
      self.state ||= "En proceso"
   end
   
   validate :check_dimensions, :on => :create
   def check_dimensions
    if !pictureOriginal_cache.nil? && (pictureOriginal.width < 800 || pictureOriginal.height < 600)
      errors.add :pictureOriginal, "Minimun size of the image is 800x600."
    end
   end
  
  
   def updateInProcess
        Design.where(state: "En proceso").find_each do |design|
   #         PictureProcess.addVariables(:firstName,:lastName,:created_at)
            design.pictureProcessed = design.pictureOriginal 
            design.enviarCorreo(:email)
            design.state = "Disponible"
            design.save
        end
   end
   
    def enviarCorreo(email)
    # Llamamos al   ActionMailer que creamos
    ActionCorreo.bienvenido_email(email).deliver_now
  
    end
end
