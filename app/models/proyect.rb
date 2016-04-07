class Proyect #< ActiveRecord::Base
  include Dynamoid::Document
  table :name => :proyects, :key => :id, :read_capacity => 5, :write_capacity => 5
  field :user_id,     :string
  field :name,        :string
  field :description, :string
  field :value,       :integer
  field :url,         :string
  
  before_save :defineUrl
  belongs_to :user
  has_many :designs, dependent: :destroy
  
 # default_scope -> { order(created_at: :desc) }
  validates :user_id,     presence: true
  validates :name,        presence: true
  validates :description, presence: true
  validates :value,       presence: true, :numericality => { :greater_than => 0 }
  
    # Defines a proto-feed.
#  def feed
#    @proyect = Proyect.find(id)
#  #  @proyect.designs
#    Design.where(:proyect_id => id).consistent.all
#  end
  
  private
  def defineUrl
    self.url =  User.find_by_id(self.user_id).webPage+"/"+Proyect.count.to_s
  end
  
  
end
