require 'timeout'

#Class to parse and hold the client's request

class Request
	attr_reader :method, :uri, :version, :headers, :body

  def initialize(socket)
    @socket_content  =  socket 
    @headers = {}
  end

  def parse
    parse_first_line
    parse_headers
    parse_body
  end

  def parse_first_line
    #parse the method 
    line = @socket_content.gets.split()
    @method = line[0]
    #Checks to see if user forgot to put in a slash at the end of a directory
    #Ignores if uri ends with filename, if includes "."
    if line[1].include?(".")
      @uri = line[1]
    elsif line[1].end_with?("/")
      @uri = line[1]
    else
      @uri = line[1]+"/"
    end
    @version = line[2]
  end

  def parse_headers
    #parse the header
    line = @socket_content.gets
    while (line != "\r\n")
      key, value = line.chomp!.split(': ', 2)
      @headers[key] = value
      line = @socket_content.gets
    end
  end

  def parse_body
    #parse body
    #Using timeouts just in case there is no body and the stream takes up 0.5
    #seconds to read when there's nothing there
    begin
      timeout(0.5) do
        line = @socket_content.gets
        puts line.is_instance_of? String
        while (line != "")
          puts line
          @body += line
          line = @socket_content.gets
        end
      end
    rescue Timeout::Error
      @body = ""
    end
  end
end