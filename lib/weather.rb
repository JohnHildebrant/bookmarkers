require 'barometer'

class Weather
  
  def initialize( city )
    @barometer = Barometer.new( city ) rescue nil
    #@barometer = nil #testing error_message
  end
  
  def forecast
    connected? ? @barometer.measure.forecast : error_message
  end
  
  def now
    connected? ? @barometer.measure.current : error_message
  end
  
  def today
    @barometer.measure.today
  end
  
  def connected? 
    @barometer ? true : false
  end
  
  def error_message
    "Can't connect to service"
  end

end