

class Film < ActiveRecord::Base
  
  has_many :events
  
  validates :title, presence: true
  validates :year, presence: true
  validates :length, presence: true
  validates :synopsis, presence: true
  
  # attr_reader :id
  # attr_accessor :title, :year, :length, :synopsis, :trailer, :rt_rating
  #
  # extend Class_Methods
  # include Instance_Methods
  #
  # def initialize(options)
  #   @id = options["id"]
  #   @title = options["title"]
  #   @year = options["year"]
  #   @length = options["length"]
  #   @synopsis = options["synopsis"]
  #   @trailer = options["trailer"]
  #   @rt_rating = options["rt_rating"]
  # end
  
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
  # def insert
  #   DATABASE.execute("INSERT INTO films (title, length, year, synopsis, trailer, rt_rating) VALUES ('#{@title}', '#{@length}', '#{@year}', '#{@synopsis}', '#{@trailer}', '#{@rt_rating}')")
  #   @id = DATABASE.last_insert_row_id
  # end
  #
  # def insert
  #   DATABASE.execute("INSERT INTO films (title, length, year, synopsis, trailer, rt_rating) VALUES ('#{@title}', '#{@length}', '#{@year}', ?, '#{@trailer}', '#{@rt_rating}')", "#{@synopsis}")
  #   @id = DATABASE.last_insert_row_id
  # end
  
end #class