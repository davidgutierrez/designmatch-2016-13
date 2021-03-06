class User #< ActiveRecord::Base
  include Dynamoid::Document
  table :name => :users, :key => :id, :read_capacity => 5, :write_capacity => 5
  field :name,      :string
  field :email,     :string
  field :webPage,   :string
  field :password_salt, :string 
	field :password_hash, :string 
	

	attr_accessor :password
 	before_save :encrypt_password
 	
  has_many :proyects, dependent: :destroy
  before_save :defineWeb
  
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,   presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true, confirmation: true
  validates :password_confirmation, presence: true


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)	
		end
  end  
	
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Defines a proto-feed.
  def feed
    Proyect.where(:user_id => id).all
  end

  def authenticate(password)
	    return self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)	
  end
  
  private
  def defineWeb
    webPage = self.name + (User.count.to_s)
    if(self.name.gsub!(/[^0-9A-Za-z]/, '') != nil)
      webPage = self.name.gsub!(/[^0-9A-Za-z]/, '') + (User.count.to_s)

    end
    self.webPage = webPage
  end
  
end
