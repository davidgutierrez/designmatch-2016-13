source 'https://rubygems.org'
ruby "2.3.0"
gem 'rails',                   '4.2.2'
gem 'bcrypt',                  '3.1.7'
gem 'faker',                   '1.4.2'
gem 'carrierwave' #,             '0.10.0'
gem 'carrierwave_direct'
gem "fog-aws"
gem 'mini_magick',             '3.8.0'
gem 'will_paginate',           '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',          '3.2.0.0'
gem 'sass-rails',              '5.0.2'
gem 'uglifier',                '2.5.3'
gem 'coffee-rails',            '4.1.0'
gem 'jquery-rails',            '4.0.3'
gem 'turbolinks',              '2.3.0'
gem 'jbuilder',                '2.2.3'
gem 'sdoc',                    '0.4.0', group: :doc
gem 'whenever',           require: false
gem 'aws-ses'
#gem 'dalli-elasticache' #old AWS gem
gem 'iron_cache_rails', :git =>  'git://github.com/iron-io/iron_cache_rails.git'
gem 'aws-sdk', '~> 1.66.0'
gem 'dynamoid', :git => "https://github.com/chrisrecalis/Dynamoid.git"
gem 'carrierwave-aws'

#autoscaling heroku
gem "hirefire-resource", github: "jtuburon/hirefire-resource"

group :development, :test do
#  gem 'sqlite3',     '1.3.9'
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.1.3'
end

group :test do
#  gem 'pg',             '0.17.1'
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'puma',           '2.11.1'
end