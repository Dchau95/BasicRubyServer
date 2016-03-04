require 'socket'
require_relative 'response'
require_relative 'request'
require_relative 'config_file'

class WebServer
  attr_reader :options, :mime_types, :httpd_config

  DEFAULT_PORT = 56789

  def initialize(options={})
    @options = options
  end

  def read_config_file(file)
    File.readlines(file)
  end

  def start
    lines = read_config_file('./config/httpd.conf')
    #initialize mime_types and httpd_config and pass lines
    #into their constructor
    loop do
      puts "Listening for connections"
      client = server.accept
      puts "Connection received"
      requestObj = Request.new(client.gets)
      requestObj.parse
      puts requestObj.method
      puts requestObj.uri
      puts requestObj.version
      puts requestObj.headers
      puts Response.new.to_s
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
