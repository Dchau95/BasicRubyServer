require 'digest'
require 'base64'
require_relative 'htaccess'
#Class to check if user is authorized

class HtaccessChecker
  def initialize(path, headers)
    @path = path
    @headers = headers
  end

  def protected?
    file = File.exist?(@path)
  end

  def can_authorize?
    encrypted_string = @headers["Authorization"]
    encrypted_string != nil ? true : false
  end

  def authorized?
    htaccess = Htaccess.new(File.readlines(@path))
    htaccess.load
    file = File.open(htaccess.auth_user_file, 'r')
    content = file.read()
    encrypted_string = @headers["Authorization"].split("Basic")
    decoded_string = Base64.decode64(encrypted_string[1])
    sha_encoded_string = Digest::SHA1.base64digest(decoded_string.split(":")[1])
    content.include?(sha_encoded_string) ? true : false
  end
end