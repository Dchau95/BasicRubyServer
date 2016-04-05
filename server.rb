require 'socket'
require_relative 'response'
require_relative 'request'
require_relative 'config_file'
require_relative 'worker'
#Server class, to listen for client's request and then pass it to a worker

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
    mime_types = MimeTypes.new(read_config_file('config/mime.types'))
    httpd_config = HttpdConfig.new(read_config_file('config/httpd.conf'))
    mime_types.load
    httpd_config.load
    logger = Logger.new(httpd_config.log_file)
    loop do
      puts "Listening for connections"
      Thread.fork(server.accept) do |client|
        worker = Worker.new(client, httpd_config, mime_types, logger)
        begin
          worker.parse_stream
        rescue
          response = Response.new("HTTP/1.1", 500, "Content-Type: text/html\r\n", 
            File.read("public_html/500.html"))
          client.puts response
        end
      end
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
