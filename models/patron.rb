

class Patron < ActiveRecord::Base

  has_many :events_patrons
  has_many :events, :through => :events_patrons
  
  # attr_reader :id
  # attr_accessor :first_name, :last_name, :username, :password
  #
  # extend Class_Methods
  # include Instance_Methods
  #
  # def initialize(options)
  #   @id = options["id"]
  #   @first_name = options["first_name"]
  #   @last_name = options["last_name"]
  #   @username = options["username"]
  #   @password = options["password"]
  #
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
  #   DATABASE.execute("INSERT INTO patrons (first_name, last_name, username, password) VALUES ('#{@first_name}', '#{@last_name}', '#{@username}', '#{@password}')")
  #   @id = DATABASE.last_insert_row_id
  # end
  #
  # def self.get_user(username)
  #   results = DATABASE.execute("SELECT * FROM patrons WHERE username = '#{username}'")
  #   if results.count == 0
  #     return nil
  #   else
  #     object = self.new(results[0])
  #     object
  #   end
  # end
  
end #class