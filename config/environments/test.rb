Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static file server for tests with Cache-Control for performance.
  config.serve_static_files   = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
    
  config.action_mailer.delivery_method = :smtp
#  config.action_mailer.smtp_settings = {
#  address:              ENV["EMAIL_ADDRESS"],
#  port:                 ENV["EMAIL_PORT"],
#  user_name:            ENV["EMAIL_USER_NAME"],
#  password:             ENV["EMAIL_PASSWORD"],
#  authentication:       :login,
#  enable_starttls_auto: true, 
#  ssl:                  true}

 # Memcached configuration Amazon CONFIG
 # endpoint    = ENV['AWS_ELASTICWEB']
 # elasticache = Dalli::ElastiCache.new(endpoint)
 # config.cache_store = :dalli_store, elasticache.servers, {:expires_in => 1.day, :compress => true}
 
 # IronCache Store
    config.cache_store =  :iron_cache, {project_id: ENV['IRON_PROJECTID'], token: ENV['IRON_TOKEN']}
end
