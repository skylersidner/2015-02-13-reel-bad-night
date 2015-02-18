
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
  def all(table)
    results = DATABASE.execute("SELECT * FROM '#{table}'")
    
    convert_to_objects(results)
#     results_as_objects = []
#     results.each do |x|
#       results_as_objects << self.new(x)
#     end
#     results_as_objects
  end
  
  #---------------------------------------------------------
  # Public: .search
  # Searches the database for records.
  #
  # Parameters:
  # field_name  - String: The name of field in the database.
  # choice      - String/Integer: The corresponding values for that field.
  #
  # Returns: An array of objects matching the search.
  #
  # State Changes: None
  #---------------------------------------------------------
  def search(table_name, field_name, value)
    if value.is_a?(String)
      results = DATABASE.execute("SELECT * FROM #{table_name} WHERE #{field_name}='#{value}'")
    else
      results = DATABASE.execute("SELECT * FROM #{table_name} WHERE #{field_name}=#{value}")
    end
    convert_to_objects(results)

  end
  
  
  # # Method for finding a specific record when you know the id.
  # # This is the same as search, but shorter, more specific.
  # def specific(table_name, id)
  #   results = DATABASE.execute("SELECT * FROM #{table_name} WHERE id=#{id}")
  #   obj = self.new(results)
  #   obj
  # end
  
  #---------------------------------------------------------
  # Public: .delete
  # Removes a record from the database, based on its ID
  #
  # Parameter:
  # id  - Integer: The ID of the record to be removed.
  #
  # Returns: None
  #
  # State Changes: Removes the record from the database.
  #---------------------------------------------------------
  def delete(table_name, id)
      DATABASE.execute("DELETE FROM #{table_name} WHERE id = #{id}")
  end
  
  private
  
  def convert_to_objects(results)
    results_as_objects = []
    results.each do |x|
      results_as_objects << self.new(x)
    end
    results_as_objects
  end
  
  
end