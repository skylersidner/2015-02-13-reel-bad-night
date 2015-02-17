

class Event
  
  attr_reader :id
  attr_accessor :date, :doors_open, :start_time, :host_msg
  
  extend Class_Methods
  include Instance_Methods
  
  def initialize(options)
    @id = options["id"]
    @date = options["date"]
    @doors_open = options["doors_open"]
    @start_time = options["start_time"]
    @host_msg = options["host_msg"]
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
    DATABASE.execute("INSERT INTO events (date, doors_open, start_time, host_msg) VALUES ('#{@date}', '#{@doors_open}', '#{@start_time}', '#{@host_msg}')")
    @id = DATABASE.last_insert_row_id
  end
  
end #class