class Resource
  attr_reader :uri_request, :conf, :mimes

  def initialize(uri_request, httpd_conf, mimes)
    @uri_request = uri_request
    @conf = httpd_conf
    @mimes = mimes
    @resource_hash = {}
  end

  def resolve
    if @conf.aliases != [] 
      @resource_hash[:absolute_path] = @conf.alias_path + @uri_request.uri.sub(@conf.aliases[0], "") + "/" + @conf.directory_index
    elsif @conf.script_aliases != [] 
      @resource_hash[:absolute_path] = @conf.script_alias_path + @uri_request.uri.sub(@conf.script_aliases[0], "")
    else
      @resource_hash[:absolute_path] = @conf.document_root + @uri_request.uri + "/" + @conf.directory_index 
    end
    @resource_hash[:absolute_path]
  end

  def mime_type
  end

  def script?
  end

  def script_aliased?
    @conf.script_aliases != [] ? true : false
  end

  def protected?
    @uri_request.uri.include?(Dir.pwd) ? true : false
  end
end