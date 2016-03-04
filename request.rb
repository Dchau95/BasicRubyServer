class Request
	attr_accessor :method, :uri, :version, :headers, :body

  def initialize(socket)
  #constructor, and then parse the Request
    @socket_content  =  socket #you can replace it with a string here
    @file = @socket_content.split("\n")
    @request_hash = {}
  end

  def parse
    parse_method
    parse_uri
    parse_version
    parse_headers
    parse_body
  end

  def parse_method
    #parse the method 
      line = @file[0].split()
      @request_hash[:method] = @method = line[0]
  end

  def parse_uri
    #parse uri
      line = @file[0].split()
      split_array = line[1].split("?")
      @request_hash[:uri] = @uri = split_array[0]
  end

  def parse_version
    #parse version
    line = @file[0].split()
    @request_hash[:version] = @version = line[2]
  end

  def parse_headers
    #parse header
    @request_hash[:headers] = {}
    i = 1 #line number
    while (@file[i])
      #puts @file[line_nu]
      line = @file[i].split(":\s")
      line[0].upcase.gsub("-", "_") == "CONTENT_LENGTH" ? @request_hash[:headers][line[0].upcase.gsub("-", "_")] = body().length.to_s : @request_hash[:headers][line[0].upcase.gsub("-", "_")] = line[1].gsub(" ", "")
      i = i + 1
    end
    @headers = @request_hash[:headers]
  end

  def parse_body
    #parse body
    i = 0
    body = ""
    @file.each do |line|
      i = i + 1
      if line == ""
        size = @file.size
        while i < size
          body = body + @file[i] + "\n"
          i = i + 1
        end
        break
      end
    end
    @request_hash[:body] = @body = body.chomp
  end    
end
