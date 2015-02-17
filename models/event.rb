

class Event
  
  attr_reader :id
  attr_accessor :date, :doors_open, :start_time, :host_msg
  
  extend Class_Methods
  
  def initialize(options)
    @id = options["id"]
    @date = options["date"]
    @doors_open = options["doors_open"]
    @start_time = options["start_time"]
    @host_msg = options["host_msg"]
  end
  
end #class