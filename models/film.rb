

class Film
  
  attr_reader :id
  attr_accessor :title, :year, :synopsis, :trailer, :rt_rating
  
  extend Class_Methods
  include Instance_Methods
  
  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @year = options["year"]
    @synopsis = options["synopsis"]
    @trailer = options["trailer"]
    @rt_rating = options["rt_rating"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation to the database
  #
  # Parameters: None
  #
  # Returns: The ID value of the new record.
  #
  # State Changes: Creates a new record in the database.
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO films (title, year, synopsis, trailer, rt_rating) VALUES ('#{@title}', '#{@year}', '#{@synopsis}', '#{@trailer}', '#{@rt_rating}')")
    @id = DATABASE.last_insert_row_id
  end
  
end #class