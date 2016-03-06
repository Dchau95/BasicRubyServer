require 'socket'
require_relative 'logger'
require_relative 'config_file'
require_relative 'response_factory'

class Worker
	#client (a reference to the stream that the server received a new request on)

  def initialize (client, config, logger)
  	@client = client
  	@config = config
  	@logger = logger
  end

  def parse_stream
  	puts "Connection Received"
  	#Creates request, do begin rescue end and see if gets 400
  	requestObj = Request.new(client.gets)
  	requestObj.parse
  	#Check resource and access somewhere here doing necessary begin rescue end
  	#following above, create htaccess checker object? Do stuff
  	#create new ResponseFactory
  	#Log the response
  	#Send response back
  end

end