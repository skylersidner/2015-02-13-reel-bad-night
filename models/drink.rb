

class Drink < ActiveRecord::Base
  
  # attr_reader :id
  # attr_accessor :name, :type, :description, :event_id
  
  # extend Class_Methods
  # include Instance_Methods
  
  # def initialize(options)
  #   @id = options["id"]
  #   @name = options["name"]
  #   @type = options["type"]
  #   @description = options["description"]
  #   @event_id = options["event_id"]
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
    DATABASE.execute("INSERT INTO drinks (name, type, description, event_id) VALUES ('#{@name}', '#{@type}', '#{@description}', '#{@event_id}')")
    @id = DATABASE.last_insert_row_id
  end
  
end #class