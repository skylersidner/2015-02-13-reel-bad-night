["/films", "/films/*"].each do |path|
  before path do
    @title = "Films"
    @table = ["id", "title", "year", "length", "synopsis", "trailer", "rt_rating"]
  end
end


get "/films" do
  @results = Film.all
  erb :"/display/display_films"
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
  @new = Film.create(params)
  # @new = Film.new(params)
  # @new.insert
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
  @results = Film.where params[:search_field]=> params[:value]
  erb :"/display/display_films"
end

get "/films/:id/show" do
  @object = Film.find_by id: params[:id]
  erb :"/display/display_film"
end

get "/films/:id/edit" do
  @object = Film.find_by id: params[:id]
  erb :"/manipulate/edit_film"  
end

get "/films/:id/update" do
  @object = Film.find_by id: params[:id]
  @object.update(title: params[:title], year: params[:year], length: params[:length], synopsis: params[:synopsis], trailer: params[:trailer], rt_rating: params[:rt_rating])
  redirect "/films/#{@object.id}/show"
end

get "/films/:id/confirm" do
  @object = Film.find_by id: params[:id]
  erb :"/manipulate/confirm_film"
end

get "/films/:id/delete" do
  @object = Film.find_by id: params[:id]
  @object.destroy
  redirect "/films"  
end