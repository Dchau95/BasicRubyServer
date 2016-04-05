#Child of ConfigFile that Parses, stores and hashes values from httpdconfig file
require_relative 'config_file'
class HttpdConfig < ConfigFile
  attr_reader :httpdconfig_hash
  def load
    super
    process_lines
  end

  def process_lines
    @httpdconfig_hash = {}
    #Check each line to see if there's more than 3 elements(ie Script Alias)
    #If so, store that information into a hash of hashes
    @lines.each do |conf_line|
      if conf_line.length < 3
        httpdconfig_hash[conf_line[0]] = conf_line[1].gsub(/"/, "")
      else
        if httpdconfig_hash.has_key?(conf_line[0])
          httpdconfig_hash[conf_line[0]][conf_line[1]] = conf_line[2].gsub(/"/, "")
        else
          httpdconfig_hash[conf_line[0]] = {conf_line[1] => conf_line[2].gsub(/"/, "")}
        end
      end
    end
  end

	# returns values from server root
  def server_root
    @httpdconfig_hash["ServerRoot"]
  end

  #returns documentroot values
  def document_root
    @httpdconfig_hash["DocumentRoot"]
  end

  #returns listen values
  def listen
    @httpdconfig_hash["Listen"]
  end

  #returns logfile values
  def log_file
    @httpdconfig_hash["LogFile"] 
  end

  def script_alias
    @httpdconfig_hash["ScriptAlias"]
  end

  #return an hash of alias directories
  def alias
    @httpdconfig_hash["Alias"]
  end

  def access_file_name
    @httpdconfig_hash["AccessFileName"]
  end

  def directory_index
    @httpdconfig_hash["DirectoryIndex"]
  end

	def script_alias_path(directory)
    @httpdconfig_hash["ScriptAlias"] != [] ? @httpdconfig_hash["ScriptAlias"][directory] : nil
	end

  #return an alias path given an directory
  def alias_path(directory)
    @httpdconfig_hash["Alias"] != [] ? @httpdconfig_hash["Alias"][directory] : nil
  end
end