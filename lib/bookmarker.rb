class Bookmarker
  
  def initialize( url, title=nil, note=nil )
    @url   = url
    @title = (title and title !="") ? title : @url
    @note  = note
  end
    
  attr_accessor :url, :title, :note
  
  def to_a
    [ self ]
  end
  
end
