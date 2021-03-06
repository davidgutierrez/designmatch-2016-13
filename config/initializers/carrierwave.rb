require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
	config.fog_credentials = {
		provider:              'AWS',								# required
		aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],			# required
		aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],		# required
	}
	config.fog_directory  = ENV['AWS_FOG_DIRECTORY']    			# required
end