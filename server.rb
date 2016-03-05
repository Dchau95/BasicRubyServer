require 'socket'
require_relative 'response'
require_relative 'request'
require_relative 'config_file'
require_relative 'worker'

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
      Thread.fork(server.accept) do |client|
        logger = Logger.new(filepath)
        worker = Worker.new(client)
        client.close
      end
    end
  end

  def server
    @server ||= TCPServer.open(options.fetch(:port, DEFAULT_PORT))
  end
end
