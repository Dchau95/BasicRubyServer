class Response
  attr_reader :version, :response_code, :headers, :body

  RESPONSE_CODES = {
    100 => "Continue",
    101 => "Switching Protocols",
    102 => "Processing",
    200 => "OK",
    201 => "Created",
    202 => "Accepted",
    204 => "No Content",
    301 => "Moved Permanently",
    304 => "Not Modified",
    400 => "Bad Request",
    401 => "Unauthorized",
    403 => "Forbidden",
    404 => "Not Found",
    500 => "Internal Server Error",
    503 => "Service Unavaiable"
    }

	def initialize(version, response_code, header, body)
    @version = version
    @response_code = response_code
    @headers = HeadersCollection.new(header)
    @body = body
  end

	def to_s
		@headers.parse
		"#{@version} #{@response_code} #{RESPONSE_CODES[@response_code]}\n"+
		"#{@headers.to_s} \n\n#{@body}"
	end
end

class HeadersCollection

	attr_reader :headers

	def initialize(str)
		@headers = {}
		@lines = str
	end

	def parse
		@lines.split("\n").each do |line|
			temp = line.split(": ")
			headers[temp[0]] = temp[1]
		end
	end

	def to_s
		headers.map { |key, value|
			"#{key}: #{value}"
		}.join("\n")
	end
end