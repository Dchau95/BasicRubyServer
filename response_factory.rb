require_relative 'request'
require_relative 'resource'
require_relative 'response'
require_relative 'htaccess_checker'

#Class to generate the responses, based on certain conditions

class ResponseFactory
  def self.create(request, resource)
    resolved_uri = resource.resolve

    htaccess_checker = HtaccessChecker.new("public_html/protected/.htaccess", 
                          request.headers)
    if htaccess_checker.protected?
      if !htaccess_checker.can_authorize?
        return Response.new("HTTP/1.1", 401, "Content-Type: text/html\r\nWWW-Authenticate: Basic\r\n", 
          File.read("public_html/401.html"))
      else
        if !htaccess_checker.authorized?
          return Response.new("HTTP/1.1", 403, "Content-Type: text/html\r\n", 
            File.read("public_html/403.html"))
        end
      end
    end

    if(!File.exist?(resolved_uri))
      return Response.new("HTTP/1.1", 404, "Content-Type: text/html\r\n", 
        File.read("public_html/404.html"))
    end

    #check script alias, if true do IO.popen
    if(resource.script?)
      IO.popen([{'ENV'=>'value'}, resolved_uri+"perl_env"]) {
        |script| 
        return Response.new("HTTP/1.1", 200, "", script.read)
      }
    end

    case request.method
    when "GET"
      return Response.new("HTTP/1.1", 200, "Content-Type: text/html\r\n", 
        File.read(resolved_uri))
    when "HEAD"
      return Response.new("HTTP/1.1", 200, "Content-Type: text/html\r\n", 
        "")
    when "POST"
      #Not sure how to implement
      return Response.new("HTTP/1.1", 200, "Content-Type: text/html\r\n", "")
    when "PUT"
      #Not tested fully
      File.open(resolved_uri, 'a') {|file| file.write(request.body)}
      return Response.new("HTTP/1.1", 201, "Content-Type: text/html\r\n", 
        File.read("public_html/put.html"))
    when "DELETE"
      File.delete(resolved_uri)
      return Response.new("HTTP/1.1", 204, "Content-Type: text/html\r\n", 
        File.read("public_html/delete.html"))
    end
  end
end