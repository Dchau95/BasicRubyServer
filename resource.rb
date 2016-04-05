require_relative 'httpd_config'
require_relative 'mime_types'
#Class to resolve URI

class Resource
  attr_reader :uri_request, :conf, :mimes

  def initialize(uri_request, httpd_conf, mimes)
    @uri_request = uri_request
    @conf = httpd_conf
    @mimes = mimes
    @script = false
  end

  def resolve
    resolved_string = ""
    if aliased?
      matched_path = match_keys(@conf.alias)
      resolved_string = @uri_request.sub(matched_path,
                              @conf.alias_path(matched_path))
    elsif script_aliased?
      matched_path = match_keys(@conf.script_alias)
      resolved_string = @uri_request.sub(matched_path,
                            @conf.script_alias_path(matched_path))
      @script = true
      return resolved_string
    else
      resolved_string = @conf.document_root.chop + @uri_request
    end

    #Do we need to always prepend after, according to the flowchart?
    #resolved_string = @conf.document_root.gsub(/"/, "").chop + resolved_string

    #Checks if the last part of the URL is a file within mime types ie. html etc
    file_check = resolved_string.split("/")[-1].split(".")

    if(mimes.for(file_check[1]) == nil)
      resolved_string += @conf.directory_index
    end

    resolved_string
  end

  def match_keys (aliases)
    alias_keys = aliases.keys
    alias_keys.each do |symbolic_path|
      @uri_request.match(symbolic_path){|path| return path.to_s}
    end
  end

  def mime_type
    @mimes
  end

  def script?
    @script
  end

  def aliased?
    if(@conf.alias != [] && @conf.alias != nil ? true : false)
      @conf.alias.keys.include? @uri_request
    else
      false
    end
  end

  def script_aliased?
    if(@conf.script_alias != [] && @conf.script_alias != nil ? true : false)
      @conf.script_alias.keys.include? @uri_request
    else
      false
    end
  end
end