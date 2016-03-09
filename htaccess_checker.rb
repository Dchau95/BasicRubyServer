require_relative 'config_file'

class htaccess_checker 

	attr_reader: :path, :headers

	def initialize(path, headers)
  	  @path = path
  	  @headers = headers
  	end
	
	def protected?
	  file = File.exist?(@path)
	end

	def can_authorize?
	    encrypted_string = @headers.split("Authorization: Basic")
	    encrypted_string != nil ? true : false


	end

	def authorized?
		file = File.open(@path, 'r')
		content = file.read().
		encrypted_string = @headers.split("Authorization: Basic")
		decoded_string = Base64.decode64(encrypted_string)
      	content.include?(decoded_string) ? true : false

	end
end
