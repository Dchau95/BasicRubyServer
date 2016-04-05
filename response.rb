#Class to hold the Response

class Response
  attr_reader :version, :response_code, :headers, :body

  RESPONSE_CODES = {
    200 => "OK",
    201 => "Created",
    202 => "Accepted",
    204 => "No Content",
    301 => "Moved Permanently",
    400 => "Bad Request",
    401 => "Unauthorized",
    403 => "Forbidden",
    404 => "Not Found",
    500 => "Internal Server Error",
  }

  def initialize(version, response_code, header, body)
    @version = version
    @response_code = response_code
    @headers = HeadersCollection.new(header+"Content-Length: #{body.bytesize}")
    #Since we are just appending the body in CGI cases, we have to format the
    #body just in case the body is just an HTML file
    if !body.start_with? "<"
      @body = body
    else
      @body = "\r\n\r\n"+body
    end
  end

  def to_s
    @headers.parse
    date = Time.new.strftime("%a, %d %b %Y %H:%M:%S %Z")
    "#{@version} #{@response_code} #{RESPONSE_CODES[@response_code]}\r\n"+
    "Server: server-12\r\nDate: #{date}\r\n#{@headers.to_s} #{@body}"
  end
end

#Class to hold all of the Headers

class HeadersCollection

  attr_reader :headers

  def initialize(str)
   @headers = {}
   @lines = str
  end

  def parse
    @lines.split("\r\n").each do |line|
      temp = line.split(": ")
      headers[temp[0]] = temp[1]
    end
  end

  def to_s
    headers.map { |key, value|
      "#{key}: #{value}"
    }.join("\r\n")
  end
end