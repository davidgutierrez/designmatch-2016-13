class PictureProcess < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    process resize_to_limit: [800, 600]
  process :add_text

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "/mnt/home/ubuntu/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
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
    if(model.created_at!=nil)
      "#{model.created_at.strftime('%Y%d%m')}.png"
    else
      "file.png"
    end
  end
end
