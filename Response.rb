class Response
	attr_reader :version
	attr_reader :responseCode
	attr_reader :responsePhrase
	attr_reader :headers
	attr_reader :body

	def initialize(version = "HTTP/1.1", responseCode = "200", responsePhrase = "OK", 
					headers = "This works", body = "Tight")
		@version = version
		@responseCode = responseCode
		@responsePhrase = responsePhrase
		@headers = headers
		@body = body
	end

	def to_s
		version+" "+responseCode+" "+responsePhrase+"\n"+headers+"\n\n"+body
	end
end