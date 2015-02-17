

class Film
  
  attr_reader :id
  attr_accessor :title, :year, :synopsis, :trailer, :rt_rating
  
  extend Class_Methods
  
  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @year = options["year"]
    @synopsis = options["synopsis"]
    @trailer = options["trailer"]
    @rt_rating = options["rt_rating"]
  end
  
end #class