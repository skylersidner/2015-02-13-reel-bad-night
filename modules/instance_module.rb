

def convert_to_objects(results)
  results_as_objects = []
  results.each do |x|
    results_as_objects << self.new(x)
  end
  results_as_objects
end