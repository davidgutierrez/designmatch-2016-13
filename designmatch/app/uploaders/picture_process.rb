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
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def add_text()
    manipulate! do |image|
        image.combine_options do |c|
          c.gravity 'Center'
          c.pointsize '22'
          c.draw "text 0,0  "+model.firstName+" "+model.lastName+" - "+(model.created_at.strftime('%d/%m/%Y'))
          c.fill 'white'
        end
#      image.format("png")
      image
    end    
  end
  

end
