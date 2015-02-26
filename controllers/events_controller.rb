
before "/events/*" do
  @title = "Events"
end


get "/events" do
  @results = Event.all("events")
  erb :"/display_all"
end

get "/events/new" do
  @table = ["date", "doors_open", "start_time", "current_event", "film_id", "host_msg"]
  create_blank_fields_hash #helper
  @object = Event.new(@blank_fields_hash) #populate fields
  erb :"/new"
end

get "/events/save" do
  @new = Event.new(params)
  @new.insert
  redirect :"/events/#{@new.id}"
end

get "/events/:id" do
  @object = Event.find_specific("events", params[:id])
  erb :"/display_object"
end

get "/events/:id/edit" do
  
end

get "/events/:id/update" do
  
end

get "/events/:id/delete" do
  
end