class Design #< ActiveRecord::Base
    include Dynamoid::Document
    extend CarrierWave::Mount
    
    table :name => :designs, :key => :id, :read_capacity => 5, :write_capacity => 5
    
    field :proyect_id,          :string
    field :email,               :string
    field :firstName,           :string
    field :lastName,            :string
    field :state,               :string
    field :offer,               :integer
    field :original_filename,   :string
    field :consecutivo,         :string

    after_initialize :initState
    before_create :initConsecutivo
    attr_accessor :pictureOriginal

    belongs_to :proyect
    validates :proyect_id       , presence: true
    validates :email            , presence: true
    validates :firstName        , presence: true
    validates :lastName         , presence: true
    validates :offer            , presence: true
    validates :pictureOriginal  , presence: true

   
    mount_uploader :pictureProcessed, PictureProcess
   
   def initState
       self.state ||= "En proceso" if self.new_record?
   end

   def initConsecutivo
       self.consecutivo ||= Design.all.count if self.new_record?
   end
#  validate :check_dimensions, :on => :create
#  def check_dimensions
#      if !pictureOriginal_cache.nil? &&  (pictureOriginal.width < 800 || pictureOriginal.height < 600)
#          errors.add :pictureOriginal, "Minimun size of the image is 800x600."
#      end
#  end
   
  def pictureOriginal= image
      self.consecutivo ||= Design.all.count
      self.original_filename ||= image.original_filename
      key = "uploads/pictureOriginal/"+self.consecutivo.to_s+"/"+original_filename
      s3.buckets[ENV['AWS_FOG_DIRECTORY']].objects[key].write(image.read)
  end

  def pictureOriginal
      key = "uploads/pictureOriginal/"+consecutivo.to_s+"/"+original_filename
      s3.buckets[ENV['AWS_FOG_DIRECTORY']].objects[key].url_for(:read) 
  end

    def processed
        state == "Disponible"
    end
    def getData
        firstName+" "+lastName
    end
    
    private
    def s3
        AWS::S3.new
    end
end