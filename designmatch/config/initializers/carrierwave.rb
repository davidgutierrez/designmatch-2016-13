require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
#	config.fog_credentials = {
#		provider:              'AWS',								# required
#		aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],			# required
#		aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],		# required
#	}
#	config.fog_directory  = 'desingmatch-prod'		    			# required
	
  config.storage    = :aws
  config.aws_bucket = 'desingmatch-prod'
  config.aws_acl    = :public_read
#  config.asset_host = 'http://ift.tt/1SAV3ZN'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {

    # Configuration for Amazon S3
    :provider              => 'AWS',
    :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                => ENV['AWS_REGION'],
  }

   config.storage = :aws
   config.cache_dir = "#{Rails.root}/tmp/uploads"   
end