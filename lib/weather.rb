require 'barometer'

class Weather
  
  def initialize( city )
    @barometer = Barometer.new( city ) rescue nil
    # @barometer = nil
  end
  
  def forecast
    if connected? 
      forecast = @barometer.measure.forecast
      forecast.each { |day| day.icon = get_weather_icon(:small, day.icon) }
      forecast
    else
      "Can't connect to service"
    end
  end
  
  def now
    now = @barometer.measure.current
    now.icon = get_weather_icon(:big, today.icon)
    now
  end
  
  def today
    @barometer.measure.today
  end
  
  def get_weather_icon(size, string)
    url = "<img src='/images/"+size.to_s+"/"
    case string
      when 'rain'
        url << "rainy.png' alt='rainy' />"
      when 'partlycloudy'
        url << "'partlycloudy_icon' alt='partly cloudy' />"
      when 'mostlycloudy'
        url << "'mostlycloyd_icon' alt='mostly cloudy' />"
      when 'cloudy'
        url << "cloudy.png' alt='cloudy' />"
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