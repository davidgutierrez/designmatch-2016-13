class Design #< ActiveRecord::Base
    include Dynamoid::Document
    extend CarrierWave::Mount
    
    table :name => :designs, :key => :id, :read_capacity => 5, :write_capacity => 5
    field :proyect_id,        :string
    field :email,             :string
    field :firstName,         :string
    field :lastName,          :string
    field :state,             :string
    field :offer,             :integer
    field :pictureOriginal,   :string
    field :pictureProcessed,  :string
    field :original_filename, :string

    after_initialize :init
   
    belongs_to :proyect
    validates :proyect_id       , presence: true
    validates :email            , presence: true
    validates :firstName        , presence: true
    validates :lastName         , presence: true
    validates :offer            , presence: true
    validates :pictureOriginal  , presence: true

    attr_accessor :pictureOriginal
    
    mount_uploader :pictureOriginal, PictureUploader   
    mount_uploader :pictureProcessed, PictureProcess
    
    def init
        self.state ||= "En proceso"
    end
    
    validate :check_dimensions, :on => :create
    def check_dimensions
        if !pictureOriginal_cache.nil? &&  (pictureOriginal.width < 800 || pictureOriginal.height < 600)
            errors.add :pictureOriginal, "Minimun size of the image is 800x600."
        end
    end
    
    
    def getData
        firstName+" "+lastName
    end
end
