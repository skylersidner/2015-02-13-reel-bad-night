

module Instance_Methods

  #---------------------------------------------------------
  # Public: #save
  # Saves record information from an object to the database.
  #
  # Parameters: None.
  #
  # Returns: An Array with a Hash of data for the updated record.
  #
  # State Changes: Updates data in the database.
  #---------------------------------------------------------
  def save
    attributes = []
    components_array = []

    instance_variables.each do |i|
      attributes << i.to_s.delete("@")
    end

    query_hash = {}

    attributes.each do |a|
      value = self.send(a)
      query_hash[a] = value
    end
  
    query_hash.each do |key, value|
      DATABASE.execute("UPDATE #{self.class.to_s.tableize} SET #{key} = ? WHERE id = #{id}", value)
    end
    DATABASE.execute("SELECT * FROM #{self.class.to_s.tableize} WHERE id = '#{@id}'")
  end #method 
  
  #---------------------------------------------------------
  # Public: #delete
  # Removes a record from the database, based on its ID
  #
  # Parameters: None
  #
  # Returns: An Integer of the ID where the record was just removed.
  #
  # State Changes: Removes the record from the database.
  #---------------------------------------------------------
  def delete
    id = @id
    DATABASE.execute("DELETE FROM #{self.class.to_s.tableize} WHERE id = #{@id}")
    id
  end  

end #class