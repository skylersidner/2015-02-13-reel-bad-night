

class Patron
  
  attr_reader :id
  attr_accessor :first_name, :last_name
  
  extend Class_Methods
  
  def initialize(options)
    @id = options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"] 
  end
  
end #class