# encoding: utf-8
class PictureProcess < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    process resize_to_limit: [800, 600]
  process :add_text

  include CarrierWave::MimeTypes
	process :set_content_type
	
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def path
		"https://s3.amazonaws.com/desingmatch-prod/#{store_dir()}" 
	end


  def add_text()
    begin
      @text = '"'+model.created_at.strftime('%d-%m-%Y')+'"'
      manipulate! do |image|
        image.format("png") do |c|
          c.gravity 'Center'
          c.stroke 'black'
          c.pointsize '22'
          c.draw 'text 0,-25 "'+model.firstName+'"'
          c.draw 'text 0,0 "'+model.lastName+'"'
          c.draw "text 0,25 "+@text
          c.fill 'white'
        end
      image
    end
    rescue StandardError => bang
     $stderr.print  bang
    end
  end
  
  def filename
    "file.png"
  end
end
