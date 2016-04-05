require_relative 'config_file'
#Child class of ConfigFile, parses and holds data from mime.types

class MimeTypes < ConfigFile
  attr_reader :mime_types

  def load
    super
    process_lines
  end

  def process_lines
    @mime_types = {}
    @lines.each do |mime_line|
      if(mime_line.length > 2)
        mime_line[1..-1].each do |extension|
          @mime_types[extension] = mime_line[0]
        end
      end
    end
  end

  def for(extension)
    @mime_types[extension]
  end
end