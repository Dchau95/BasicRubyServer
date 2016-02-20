require 'socket'
require_relative 'Response'
require_relative 'Request'

class WebServer
  attr_reader :options

  DEFAULT_PORT = 56789

  def initialize(options={})
    @options = options
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