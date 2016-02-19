require 'socket'
​
class WebServer
  attr_reader :options
​
  DEFAULT_PORT = 56789
  def initialize(options={})
    @options = options
  end
​
  def start
    loop do
      puts "Listening for connections"
      client = server.accept
​
      puts "Connection received"
      RequestObj = Request.new(stream)
      ResponseObj = Response.new()
​
      client.close
    end
  end
​
  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end