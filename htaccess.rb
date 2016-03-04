require_relative 'config_file'

class Htaccess < ConfigFile
  attr_reader :config

  def load
    super
    process_lines
  end

  def process_lines
    @config = {}
    lines.each do |line|
      temp = line.split(" ")
      config[temp[0]] = temp[1]
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

end 