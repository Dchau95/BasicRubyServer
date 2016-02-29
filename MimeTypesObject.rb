require_relative 'ConfigFile'

class MimeTypesObject < ConfigFile
	
  attr_reader :mime_types

  def load
    super
    process_lines
  end

  def process_lines
    @mime_types = {}
    @lines.each do |mime_line|
    temp = mime_line.split("/")
    mime_types[temp[1]] = temp[0]
    end
  end

  def for(extension)
  end
end
