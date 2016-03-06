#What the heck is filepath and file supposed to represent
class Logger
  attr_reader :filepath, :file

  def initialize(filepath)
    @filepath = filepath
  end

  def write(request, response)
    #IP address gotten from some place
    ip_address = "127.0.0.1"
    #username gotten from htaccess?
    username = "frank"
    time = Time.new.strftime("%d/%b/%Y:%H:%M:%S %z")
    request_line = "\""+request.method+" "+request.uri+" "+request.version+"\""
    response_code = response.response_code.to_s
    #Size of file returned to client
    size_of_object = "2346"
    @file = File.new(filepath, 'a')
    @file.puts(ip_address+" - "+username+" ["+time+"] "+request_line+" "+
          response_code+" "+size_of_object)
    @file.close
  end
end