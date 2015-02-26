

module RouteHelpers
  
  def create_blank_fields_hash
    @blank_fields_hash = {}
    @table.each do |field|
      @blank_fields_hash[field] = ""
    end #each
    return @blank_fields_hash
  end
  
  def get_rt_search_results
    search_results = RottenMovie.find(:title => "#{params[:search]}", :limit => 20)
    if search_results.length == nil #check if search returned a single object
      search_results = [search_results] #make it an array
    end
    search_results.each do |x| #capture relevant info from rottentomatoes
      film = Film.new("title"=>"#{x.title}", "year"=>"#{x.year}", "length"=>"#{x.runtime}", "synopsis"=>"#{x.synopsis}", "trailer"=>"", "rt_rating"=>"#{x.ratings.critics_score}")
      @results << film

      thumb = x.posters.thumbnail #capture an image of the poster
      if thumb == nil #if there isn't one, use default
        thumb = "/Users/skylersidner/Code/2015-02-13-reel-bad-night/public/images/poster_default.gif"
      end
      if thumb.include?("tmb") #minor adjustment for better image, if possible
        thumb.slice!("tmb")
        thumb.insert(-5, "det")
      end
      @thumbs << thumb
    end #each
  end #method
  
end
