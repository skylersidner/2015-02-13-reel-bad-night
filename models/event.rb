

class Event < ActiveRecord::Base
  
  # attr_reader :id, :start, :film_title
  # attr_accessor :date, :doors_open, :start_time, :host_msg, :current_event,
  #               :film_id
  #
  # extend Class_Methods
  # include Instance_Methods
  #
  # def initialize(options)
  #   @id = options["id"]
  #   @start_time = options["start_time"]
  #   @host_msg = options["host_msg"]
  #   @current_event = options["current_event"]
  #   @film_id = options["film_id"]
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
  def insert
    DATABASE.execute("INSERT INTO events (start_time, current_event, film_id, host_msg) VALUES ('#{@start_time}', '#{@current_event}', '#{@film_id}', ?)", "#{@host_msg}")
    @id = DATABASE.last_insert_row_id
  end
  
  # DOCUMENT ME!!!!!
  
  def prepare_for_display
    dt_array = convert_to_datetime_object(self)
    @start = dt_array.to_formatted_s(:long_ordinal)
    film = Film.find_specific(self.film_id)
    @film_title = film.title
    return self
  end
  
end #class