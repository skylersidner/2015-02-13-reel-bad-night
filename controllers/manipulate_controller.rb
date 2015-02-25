get "/search/*" do
  erb :"manipulate/search"
end

get "/new/*" do
  object_class = (session[:table].classify).constantize #capture object type
  create_blank_fields_hash #helper
  @object = object_class.new(@blank_fields_hash) #populate fields
  if params[:title] != nil #check to see if a page is passing film_id info
    @object = object_class.new(params)
  end
  
  erb :"manipulate/new"
end

get "/new_film_rt/*" do
  @results = []
  @thumbs = []
  if params[:search] != nil
    get_rt_search_results #helper
    if @results.count == 0
      @no_results = true
    end
  end
  erb :"manipulate/new_film_rt"
end

get "/remove/*" do  
  erb :"manipulate/search"
end

get "/edit/*" do
  erb :"manipulate/search"
end