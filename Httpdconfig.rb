#this object Parses, stores and hashes values from httpdconfig file
class HttpdConfig
	def initialize(httpd_config_file)
		@file = httpd_config_file.split("\n")
		@httpconfig_hash = {}
	end

	#scan the httpdconfigfile for a value to return
	def find_value(type)
      value = ""
      @file.each do |line|
        if line.include? type
          value = line.sub(type, "")
          value = value.gsub("\"", "")
          break
        end
      end
      value = value.gsub(" ", "")
    end  

    #scab the file for a path vaule to return
    def find_path(directory)
      path = ""
      @file.each do |line|
        if line.include? directory
          path = line.sub("ScriptAlias " + directory, "")
          path = path.sub("Alias " + directory, "")
          path = path.gsub("\"", "")
          break
        end
      end
      path = path.gsub(" ", "")
    end

    #Scans the httpd.conf to return an array of specific type of aliases 
    def find_alias(alias_type)
      alias_array = []
      @file.each do |line|
        if line.include?(alias_type)
          split_array = line.split(" ")
          alias_array.push(split_array[1])
        end
      end
      alias_array
    end

	# returns values from server root
	def server_root
		@Httpdconfig_hash[:server_root] = find_value("ServerRoot")
	end

	#returns documentroot values
	def document_root
		@Httpdconfig_hash[:document_root] = find_value("DocumentRoot")
	end

	#returns listen values
	def listen
		@Httpdconfig_hash[:listen] = find_value("Listen")
	end

	#returns logfile values
	def log_file
		@Httpdconfig_hash[:log_file] = find_value("LogFile")
	end


	def script_alias
		@Httpdconfig_hash[:script_alias] = find_alias("ScriptAlias")
	end

	def script_alias_path(directory)
		directory_count = directory.count("\/")
		directory_count == 2 ? @httpdconfig_hash[:script_alias_path] = find_path(directory) : nil
		@httpdconfig_hash[:script_alias_path] != "" ? @httpdconfig_hash[:script_alias_path] : nil
	end

	#return an array of alias directories
	def alias
      @httpdconfig_hash[:alias] = find_alias("Alias")
    end

    #return an alias path given an directory
    def alias_path(directory)
    	directory_count = directory.count("\/")
		directory_count == 2 ? @httpdconfig_hash[:alias_path] = find_path(directory) : nil
		@httpdconfig_hash[:alias_path] != "" ? @httpdconfig_hash[:alias_path] : nil
    end
end





