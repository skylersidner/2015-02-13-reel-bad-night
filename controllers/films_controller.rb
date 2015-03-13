["/films", "/films/*"].each do |path|
  before path do
    @title = "Films"
    @table = ["id", "title", "year", "length", "synopsis", "trailer", "rt_rating"]
  end
end


get "/films" do
  @results = Film.all
  erb :"/display/display_results"
end

get "/films/new" do
  if params[:title] != nil
    @object = Film.new(params)
  else
    create_blank_fields_hash #helper
    @object = Film.new(@blank_fields_hash) #populate fields
  end
  erb :"/manipulate/new"
end

get "/films/save" do
  if params[:rt] == "yes"
    redirect "/films/new/rt"
  end
  @new = Film.new(params)
  @new.insert
  redirect "/films/#{@new.id}/show"
end

get "/films/new/rt" do
  @thumbs = []
  @results = []
  if params[:search] != nil
    get_rt_search_results #helper
    if @results.count == 0
      @no_results = true
    end
  end
  erb :"/manipulate/new_film_rt"
end

get "/films/search" do
  erb :"/index/search"
end

get "/films/search_results" do
  get_search_results #helper
  @admin = true
  erb :"/display/display_results"
end

get "/films/:id/show" do
  @object = Film.find_specific(params[:id])
  erb :"/display/display_object"
end

get "/films/:id/edit" do
  @object = Film.find_specific(params[:id])
  erb :"/manipulate/edit"  
end

get "/films/:id/update" do
  @object = Film.new(params)
  @object.save
  redirect "/films/#{@object.id}/show"
end

get "/films/:id/confirm" do
  @object = Film.find_specific(params[:id])
  erb :"/manipulate/confirm"
end

get "/films/:id/delete" do
  @object = Film.find_specific(params[:id])
  @object.delete
  redirect "/films"  
end