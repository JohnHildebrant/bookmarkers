class Widget
    
    def initialize( title=nil )
      @title       = title
      @name_id     = title.gsub(/[^0-9a-z]/i, '').gsub(' ', '')
      @bookmarkers = []
    end

    attr_accessor :title, :name_id, :bookmarkers
    
    def to_a
      [ self ]
    end

  end


  