# encoding: utf-8
class PictureUploader < CarrierWave::Uploader::Base
#    include CarrierWave::MiniMagick
  #  process resize_to_limit: [400, 400]
  include CarrierWave::MimeTypes
	process :set_content_type
	
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def path
		"https://s3.amazonaws.com/desingmatch-prod/#{store_dir()}" 
  end

	def url
		URI.encode("#{path()}") 
	end
	
  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg png)
  end
  
  # for image size validation
  # fetching dimensions in uploader, validating it in model
  attr_reader :width, :height
  before :cache, :capture_size
  def capture_size(file)
    if version_name.blank? # Only do this once, to the original version
      if file.path.nil? # file sometimes is in memory
        img = ::MiniMagick::Image::read(file.file)
        @width = img[:width]
        @height = img[:height]
      else
        @width, @height = `identify -format "%wx %h" #{file.path}`.split(/x/).map{|dim| dim.to_i }
      end
    end
  end

end  
