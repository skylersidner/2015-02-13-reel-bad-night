

module Instance_Methods

  #---------------------------------------------------------
  # Public: #save
  # Saves record information from an object to the database.
  #
  # Parameters: None
  #
  # Returns: None
  #
  # State Changes: Updates data in the database.
  #---------------------------------------------------------
  def save(table_name)
    attributes = []
    components_array = []

    instance_variables.each do |i|
      attributes << i.to_s.delete("@")
    end

    attributes.each do |a|
      value = self.send(a)
      if value.is_a?(Integer) || value.is_a?(Float)
        components_array << "#{a} = #{self.send(a)}"
      else
        components_array << "#{a} = '#{self.send(a)}'"
      end #if
    end #each

    q = components_array.join(", ")

    DATABASE.execute("UPDATE #{table_name} SET #{q} WHERE id = '#{@id}'")
  end #method
  
  #---------------------------------------------------------
  # Public: #delete
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
      DATABASE.execute("DELETE FROM #{table_name} WHERE id = #{@id}")
  end  
  
end #class