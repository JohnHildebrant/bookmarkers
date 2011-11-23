class Database
  
  DATABASE_URL = "db/database.yml"
  
  def self.open
    File.open(DATABASE_URL) { |file| YAML.load(file) }
  end
  
  def self.write(array)
    File.open(DATABASE_URL, 'w') { |file| YAML.dump(array, file) }
  end
  
  def self.[](index)
    self.open[index]
  end
  
  def self.add_widget(widget)
    all_widgets = self.open
    all_widgets = all_widgets ? ( all_widgets.to_a + widget.to_a ) : widget.to_a
    self.write(all_widgets)
  end
  
  def self.delete_widget(index)
    all_widgets = self.open
    all_widgets.delete_at(index.to_i)
    self.write(all_widgets)
  end
  
  def self.add_bookmarker(index, bookmarker)
    all_widgets = self.open
    all_widgets[index.to_i].bookmarkers = all_widgets[index.to_i].bookmarkers + bookmarker.to_a
    self.write(all_widgets)
  end
  
  def self.delete_bookmarker(w_index, b_index)
    all_widgets = self.open
    all_widgets[w_index.to_i].bookmarkers.delete_at(b_index.to_i)
    self.write(all_widgets)
  end
  
end