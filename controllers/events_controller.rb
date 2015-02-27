["/events", "/events/*"].each do |path|
  before path do
    @title = "Events"
    @table = ["id", "date", "doors_open", "start_time", "current_event", "film_id", "host_msg"]
  end
end


get "/events" do
  @results = Event.all
  erb :"/display/display_results"
end

get "/events/new" do
  create_blank_fields_hash #helper
  @object = Event.new(@blank_fields_hash) #populate fields
  erb :"/manipulate/new"
end

get "/events/save" do
  @new = Event.new(params)
  @new.insert
  redirect :"/events/#{@new.id}/show"
end

get "/events/search" do
  erb :"/index/search"
end

get "/events/search_results" do
  get_search_results #helper
  @admin = true
  erb :"/display/display_results"
end

get "/events/:id/show" do
  @object = Event.find_specific(params[:id])
  erb :"/display/display_object"
end

get "/events/:id/edit" do
  @object = Event.find_specific(params[:id])
  erb :"/manipulate/edit"  
end

get "/events/:id/update" do
  @object = Event.new(params)
  @object.save
  redirect :"/events/#{@object.id}/show"
end

get "/events/:id/confirm" do
  @object = Event.find_specific(params[:id])
  erb :"/manipulate/confirm"
end

get "/events/:id/delete" do
  @object = Event.find_specific(params[:id])
  @object.delete
  redirect :"/events"  
end