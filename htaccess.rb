require_relative 'config_file'
#Child class of ConfigFile to parse and store data from Htaccess

class Htaccess < ConfigFile
  attr_reader :config
  
  def load
    super
    process_lines
  end

  def process_lines
    @config = {}
    #Rework this line so that if it sees Require, it will check to see if
    #Require is for valid-users, users, or groups and then
    #parse accordingly
    lines.each do |line|
      if line.length > 2
        config[line[0]] = line[1..-1]
      else
        config[line[0]] = line[1].gsub(/"/, "")
      end
    end
  end

  def auth_user_file
		@config["AuthUserFile"]
  end

  def auth_type
    @config["AuthType"]
  end

  def auth_name
    @config["AuthName"]
  end

  def require
    @config["Require"]
  end

  def www_authenticate
    @config['WWW-Authenticate']
  end

  def authorization
    @config['Authorization']
  end
end 