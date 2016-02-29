require 'socket'
require_relative 'Response'
require_relative 'Request'
require_relative 'ConfigFile'

class WebServer
  attr_reader :options

  DEFAULT_PORT = 56789

  def initialize(options={}, mime_types, http_config)
    @options = options
    @mime_types = mime_types
    @httpd_config = httpd_config
  end

  def read_config_file

  end

  def start
    loop do
      puts "Listening for connections"
      client = server.accept
      puts "Connection received"
      requestObj = Request.new(client.gets)
      requestObj.parse
      puts Response.new.to_s
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end