#Make this a module
require 'socket'
require_relative 'logger'
require_relative 'config_file'
require_relative 'resource'
require_relative 'response_factory'

class Worker
	#client (a reference to the stream that the server received a new request on)

  def initialize (client, config, mime, logger)
  	@client = client
  	@config = config
  	@logger = logger
    @mime = mime
  end

  def parse_stream
  	puts "Connection Received"
  	
    begin
      request_obj = Request.new(@client.gets)
      request_obj.parse
    rescue
      #Error code is 400
    end
  	#Check resource and access somewhere here doing necessary begin rescue end
    resource_obj = Resource.new(request_obj.uri, @config, @mime)
  	#following above, create htaccess checker object? Do stuff
  	#create new ResponseFactory
    response_obj = ResponseFactory.create(request_obj, resource_obj)
  	#Log the response
    @logger.write(request_obj, response_obj)
  	#Send response back
  end
end