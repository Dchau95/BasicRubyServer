class ConfigFile
  
  def initialize(line_array)
    @lines = line_array
  end

  def load
    lines.select do |line|
      line.strip.Length != 0
    end.select do |line| 
      line[0] != '#'
    end.map do |line|
      line.split
    end.map do |line|
      {line[0] => line[1...-1]}
  end

end