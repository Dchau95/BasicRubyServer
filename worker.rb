require 'socket'
require_relative 'logger'
require_relative 'httpd_config'
require_relative 'resource'
require_relative 'response_factory'

#Class to handle a single request

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
    request_obj = Request.new(@client)
    begin
      request_obj.parse
    rescue
      response_obj = Response.new("HTTP 1.1", 400, "Content-Type: text/html\r\n", 
        File.read("public_html/400.html"))
      @logger.write(request_obj, response_obj)
      @client.puts response_obj
      @client.close
      return
    end
    resource_obj = Resource.new(request_obj.uri, @config, @mime)
    response_obj = ResponseFactory.create(request_obj, resource_obj)
    @logger.write(request_obj, response_obj)
    @client.puts response_obj
    @client.close
    return
  end
end