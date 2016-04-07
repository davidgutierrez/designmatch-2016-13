class Persona #< ActiveRecord::Base
  
  include ActiveModel::Validations

  attr_accessor :nombre, :email, :identificador

  validates_presence_of :nombre, :email, :identificador

  def initialize (nombre, email,identificador)
   @nombre, @email, @identificador = nombre, email, identificador
  end
end