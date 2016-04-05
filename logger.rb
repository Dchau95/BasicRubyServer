require 'socket'
require 'base64'
#Class to log the request and response

class Logger
  attr_reader :filepath, :file

  def initialize(filepath)
    @filepath = filepath
  end

  def write(request, response)
    #Cover failing?
    ip_address = TCPSocket.open(request.headers["Host"][/[^:]+/], 56789) {
      |sock| sock.addr[3]
    }
    remote_logname = "-"
    auth_header = request.headers["Authorization"]
    if auth_header != nil 
      auth_header = auth_header.split(" ")[1]
      username = Base64.decode64(auth_header).split(":")[0]
    else
      username = "-"
    end
    time = Time.new.strftime("%d/%b/%Y:%H:%M:%S %z")
    #Cover failing?
    request_line = "\""+request.method+" "+request.uri+" "+request.version+"\""
    response_code = response.response_code.to_s
    if response.body != nil
      size_of_object = response.body.bytesize.to_s
    else
      size_of_object = "-"
    end
    @file = File.new(filepath, 'a')
    @file.puts(ip_address+" "+remote_logname+" "+username+" ["+time+"] "+
                request_line+" "+response_code+" "+size_of_object+"\n")
    @file.close
  end
end