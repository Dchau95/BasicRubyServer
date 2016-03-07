require_relative 'config_file'

class MimeTypes < ConfigFile
  attr_reader :mime_types

  def load
    super
    process_lines
  end

  def process_lines
    @mime_types = {}
    @lines.each do |mime_line|
      temp = mime_line.gsub(/\s+/, ' ').split(" ")
      temp[1..-1].each do |file_extension|
        @mime_types[file_extension] = temp[0]
      end
    end
  end

  def for(extension)
    @mime_types[extension]
  end
end
