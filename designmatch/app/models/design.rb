class Design < ActiveRecord::Base
   belongs_to :proyect
   after_initialize :init
   
   default_scope -> { order(created_at: :desc) }
   validates :proyect_id, presence: true
   validates :email     , presence: true
   validates :firstName , presence: true
   validates :lastName  , presence: true
   validates :offer     , presence: true
   
   
   def init
      self.state ||= "En proceso"
   end
end
