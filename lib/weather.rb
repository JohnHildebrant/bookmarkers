require 'barometer'

class Weather
  
  def initialize( city )
    # @barometer = Barometer.new( city ) rescue nil
    @barometer = nil
  end
  
  def forecast
    if connected? 
      forecast = @barometer.measure.forecast
      forecast.each { |day| day.icon = get_weather_icon(day.icon) }
      forecast
    else
      "Can't connect to service"
    end
  end
  
  def get_weather_icon(string)
    url = "<img src="
    case string
      when 'rain'
        url << "'rain_icon' alt='rainy' />"
      when 'partlycloudy'
        url << "'partlycloudy_icon' alt='partly cloudy' />"
      when 'mostlycloudy'
        url << "'mostlycloyd_icon' alt='mostly cloudy' />"
      when 'chancesnow'
        url << "'chancesnow_icon' alt='chance of snow' />"
      else
        url = string
    end
  end
  
  def connected? 
    @barometer ? true : false
  end

end