

class Drink
  
  attr_reader :id
  attr_accessor :name, :type, :description, :event_id
  
  extend Class_Methods
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @type = options["type"] 
    @description = options["description"]
    @event_id = options["event_id"]
  end
  
end #class