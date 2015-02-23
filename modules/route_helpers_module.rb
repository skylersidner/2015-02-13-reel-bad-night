

module ErbHelpers
  
  def create_blank_fields_hash
    @blank_fields_hash = {}
    session[:fields].each do |field|
      @blank_fields_hash[field] = ""
    end #each
    return @blank_fields_hash
  end
    
end
