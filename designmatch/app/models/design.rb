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
   def init
      self.state ||= "En proceso"
   end
   
   validate :check_dimensions, :on => :create
   def check_dimensions
    if !pictureOriginal_cache.nil? && (pictureOriginal.width < 800 || pictureOriginal.height < 600)
      errors.add :pictureOriginal, "Minimun size of the image is 800x600."
    end
   end
  
end
