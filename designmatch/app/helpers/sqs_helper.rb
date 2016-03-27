require 'aws-sdk'

module SqsHelper
	def send_msg_to_queue(message)
		client = Aws::SQS::Client.new(region: ENV['AWS_REGION'])
		resp = client.send_message({
			queue_url: ENV['AWS_QUEUE_URL'],
			message_body: message,
		})
	end
	def obtain_message_from_queue
		client = Aws::SQS::Client.new(region: ENV['AWS_REGION'])
		resp = client.receive_message({
			queue_url: ENV['AWS_QUEUE_URL'],
			max_number_of_messages: 1,
		})
		return resp.messages
	end
	def delete_message_from_queue(receipt_handle)
		client = Aws::SQS::Client.new(region: ENV['AWS_REGION'])
		resp = client.delete_message({
			queue_url: ENV['AWS_QUEUE_URL'],
			receipt_handle: receipt_handle,
		})
	end	
end