

module RouteHelpers
  
  # Public: #create_blank_fields_hash
  # Takes an array (@table) of field names for that associated
  # table and creates blank string hash values for populating
  # empty form text blocks.
  #
  # Parameters: None
  #
  # Returns: A hash with field-based keys that point to an
  # an empty string.
  #
  # State Changes: None
  def create_blank_fields_hash
    @blank_fields_hash = {}
    @table.each do |field|
      @blank_fields_hash[field] = ""
    end #each
    @blank_fields_hash
  end
  
  # Public: #get_rt_search_results
  # Uses the rottentomatoes API gem to create Film objects out of
  # search results.
  #
  # Parameters: None
  #
  # Returns: An array of Film objects.
  #
  # State Changes: @results is populated with objects.
  def get_rt_search_results
    search_results = RottenMovie.find(:title => "#{params[:search]}", :limit => 20)
    if search_results.length == nil #check if search returned a single object
      search_results = [search_results] #make it an array
    end
    search_results.each do |x| #capture relevant info from rottentomatoes
      film = Film.new("title"=>"#{x.title}", "year"=>"#{x.year}", "length"=>"#{x.runtime}", "synopsis"=>"#{x.synopsis}", "trailer"=>"", "rt_rating"=>"#{x.ratings.critics_score}")
      @results << film
      
      if x.posters.thumbnail == nil
        @thumbs << "/Users/skylersidner/Code/2015-02-13-reel-bad-night/public/images/poster_default.gif"
      else
        @thumbs << x.posters.thumbnail
      end
    end #each
    @results
  end #method
  
  # Public: #get_search_results
  # Looks for specific records in the database.
  #
  # Parameters: None
  #
  # Returns: An array of objects based on search results.
  #
  # State Changes: @results is populated with objects.
  def get_search_results
    # Use Active Support to capture the right class.
    object_class = (@title.classify).constantize
    if params[:all] == "yes" #check if they want all of that type
      @results = object_class.all
    else
      @results = object_class.search(params[:search_field], params[:value])
    end #if
    @results
  end #method

  
end #module
