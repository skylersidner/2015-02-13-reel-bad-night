

class Event < ActiveRecord::Base

  has_many :drinks
  belongs_to :film

  has_many :events_patrons
  has_many :patrons, :through => :events_patrons
  
  # attr_reader :id
  # attr_accessor :start_time, :film_id, :host_msg, :current_event
  #
  # extend Class_Methods
  # include Instance_Methods
  #
  # def initialize(options)
  #   @id = options["id"]
  #   @start_time = options["start_time"] Format: YYYY-MM-DD-HH-MM (military)
  #   @film_id = options["film_id"]
  #   @host_msg = options["host_msg"]
  #   @current_event = options["current_event"]
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
  #   DATABASE.execute("INSERT INTO events (start_time, current_event, film_id, host_msg) VALUES ('#{@start_time}', '#{@current_event}', '#{@film_id}', ?)", "#{@host_msg}")
  #   @id = DATABASE.last_insert_row_id
  # end
  #
  # # DOCUMENT ME!!!!!
  # # this method will not work with ActiveRecord; need to figure out a way to create this information for the event that will work.
  # def prepare_for_display
  #   dt_array = convert_to_datetime_object(self) #date_time_module
  #   self.start_time = dt_array.to_formatted_s(:long_ordinal)
  #   # film = Film.find_specific(self.film_id)
  #   film = Film.find_by "id" => self.film_id
  #   self.film_id = film.title
  #   return self
  # end
  
end #class