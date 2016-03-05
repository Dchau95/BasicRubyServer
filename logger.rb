class logger

  attr_reader :filepath, :file

  def initialize(filepath)
    @filepath = filepath
  end

  def write(request, response)
    file = File.open("filepath", "a")
    logger = Logger.new(file)
    #request infi?
    #log response
    logger.close
  end

end