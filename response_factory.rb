require_relative 'request'
require_relative 'resource'

class ResponseFactory
  def self.create(request, resource)

    #Do something with resource here, checking for response code

    case request.method
    when "GET", "HEAD"
      #200
    when "PUT",
      #201
    when "DELETE"
      #204
  end
end