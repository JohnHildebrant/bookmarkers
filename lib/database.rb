class Database
  
  BOOKMARKERS_FILE = "db/bookmarkers.db.yml"
  WEATHER_FILE     = "db/weather.db.yml"
  
  def self.open(database)
    File.open(database) { |file| YAML.load(file) }
  end
  
  def self.write(database, array)
    File.open(database, 'w') { |file| YAML.dump(array, file) }
  end
  
  def self.drop
    self.write(BOOKMARKERS_FILE, {})
    self.write(WEATHER_FILE, {})
  end
  
  def self.add_widget(widget)
    all_widgets = self.open(BOOKMARKERS_FILE)
    all_widgets = all_widgets ? ( all_widgets.to_a + widget.to_a ) : widget.to_a
    self.write(BOOKMARKERS_FILE, all_widgets)
  end
  
  def self.delete_widget(index)
    all_widgets = self.open(BOOKMARKERS_FILE)
    all_widgets.delete_at(index.to_i)
    self.write(BOOKMARKERS_FILE, all_widgets)
  end
  
  def self.widgets
    self.open(BOOKMARKERS_FILE)
  end
  
  def self.add_bookmarker(index, bookmarker)
    all_widgets = self.open(BOOKMARKERS_FILE)
    all_widgets[index.to_i].bookmarkers = all_widgets[index.to_i].bookmarkers + bookmarker.to_a
    self.write(BOOKMARKERS_FILE, all_widgets)
  end
  
  def self.delete_bookmarker(w_index, b_index)
    all_widgets = self.open(BOOKMARKERS_FILE)
    all_widgets[w_index.to_i].bookmarkers.delete_at(b_index.to_i)
    self.write(BOOKMARKERS_FILE, all_widgets)
  end
  
  def self.city
    self.open(WEATHER_FILE)
  end
  
  def self.change_city(city)
    self.write(WEATHER_FILE, city)
  end
  
  def self.move_bookmarker(direction, w_index, b_index)
    all_widgets = self.open(BOOKMARKERS_FILE)
    bookmarker  = all_widgets[w_index.to_i].bookmarkers[b_index.to_i]
    all_widgets[w_index.to_i].bookmarkers.delete_at(b_index.to_i)
    
    all_widgets[w_index.to_i].bookmarkers.insert( (b_index.to_i + direction.to_i), bookmarker)
    self.write(BOOKMARKERS_FILE, all_widgets)
  end
  
end