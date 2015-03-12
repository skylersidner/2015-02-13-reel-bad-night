

class Patron
  
  attr_reader :id
  attr_accessor :first_name, :last_name, :password
  
  extend Class_Methods
  include Instance_Methods
  
  def initialize(options)
    @id = options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @password = options["password"]
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
    DATABASE.execute("INSERT INTO patrons (first_name, last_name, password) VALUES ('#{@first_name}', '#{@last_name}', '#{@password})")
    @id = DATABASE.last_insert_row_id
  end
  
end #class