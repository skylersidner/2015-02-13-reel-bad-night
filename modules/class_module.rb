
# Class: Class_Methods
# Extracted class methods to be used by multiple classes.
#
# Attributes: None (module)
#
# Public Methods:
# #all
module Class_Methods
  
  # Public: #all
  # Enables a class to return all records from its corresponding table.
  #
  # Parameters:
  # table - String: The name of the table to be listed.
  #
  # Returns: An array of objects.
  #
  # State Changes: None
  def all
    results = DATABASE.execute("SELECT * FROM '#{self.to_s.tableize}'")
    
    convert_to_objects(results)
  end
  
  #---------------------------------------------------------
  # Public: .search
  # Searches the database for records.
  #
  # Parameters:
  # field_name  - String: The name of field in the database.
  # value       - String/Integer: The corresponding values for that field.
  #
  # Returns: An array of objects matching the search.
  #
  # State Changes: None
  #---------------------------------------------------------
  def search(field_name, value)
    if value.is_a?(String)
      results = DATABASE.execute("SELECT * FROM #{self.to_s.tableize} WHERE #{field_name}='#{value}'")
    else
      results = DATABASE.execute("SELECT * FROM #{self.to_s.tableize} WHERE #{field_name}=#{value}")
    end
    
    convert_to_objects(results) #returns an array of objects
  end
  
  # NEEDS DOCUMENTATION
  
  # Method for finding a specific record when you know the id.
  # This is the same as search, but shorter, more specific.
  def find_specific(id)
    results = DATABASE.execute("SELECT * FROM #{self.to_s.tableize} WHERE id='#{id}'")
    object = self.new(results[0])
    object
  end
  

  private
  
  
  # NEEDS DOCUMENTATION
  
  def convert_to_objects(results)
    results_as_objects = []
    results.each do |x|
      results_as_objects << self.new(x)
    end
    results_as_objects
  end
  
  
end