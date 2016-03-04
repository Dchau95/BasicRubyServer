class ConfigFile
  
  attr_reader :lines

  def initialize(line_array)
    @lines = line_array
  end

  #Needs to take out tabs and new lines
  def load
    lines.select do |line|
      line.strip.length != 0
    end.select do |line| 
      line[0] != '#'
    end.map do |line|
      line.split
    end
  end
end