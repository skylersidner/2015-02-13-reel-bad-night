

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
      query_components_array = []

      instance_variables.each do |i|
        attributes << i.to_s.delete("@")
      end

      attributes.each do |a|
        value = self.send(a)
        if value.is_a?(Integer) || value.is_a?(Float)
          query_components_array << "#{a} = #{self.send(a)}"
        else
          query_components_array << "#{a} = '#{self.send(a)}'"
        end
      end

      q = query_components_array.join(", ")

      DATABASE.execute("UPDATE #{table_name} SET #{q} WHERE id = '#{@id}'")
  end #method
  
end #class