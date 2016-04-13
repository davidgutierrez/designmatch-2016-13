HireFire::Resource.configure do |config|
  config.dyno(:worker) do
  	require 'aws/sqs'
    HireFire::Macro::Sqs.queue("designMatchQueue")
  end
end