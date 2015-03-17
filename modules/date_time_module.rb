

module Date_Time_Methods
  
  #---------------------------------------------------------
  # Public: #convert_to_datetime_objects
  # Creates a DateTime object from an event's @start_time.
  #
  # Parameters:
  # event - Event: An Event instance.
  #
  # Returns: A new DateTime object.
  #
  # State Changes: None.
  #---------------------------------------------------------
  def convert_to_datetime_object(event)
    y = (event.start_time.slice(0..3)).to_i
    m = (event.start_time.slice(5..6)).to_i
    d = (event.start_time.slice(8..9)).to_i
    hour = (event.start_time.slice(11..12)).to_i
    min = (event.start_time.slice(14..15)).to_i
    
    DateTime.new(y, m, d, hour, min, 0, '-06:00')
  end
  
end #module