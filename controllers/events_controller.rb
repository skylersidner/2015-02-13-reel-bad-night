["/events", "/events/*"].each do |path|
  before path do
    @title = "Events"
    @table = ["id", "date", "doors_open", "start_time", "current_event", "film_id", "host_msg"]
  end
end


get "/events" do
  @results = Event.all
  erb :"/display_results"
end

get "/events/new" do
  create_blank_fields_hash #helper
  @object = Event.new(@blank_fields_hash) #populate fields
  erb :"/new"
end

get "/events/save" do
  @new = Event.new(params)
  @new.insert
  redirect :"/#{@new.id}"
end

get "/events/search" do
  erb :"/search"
end

get "events/search_results" do
  get_search_results #helper
  @admin = true
  erb :"/display_results"
end

get "/events/:id" do
  @object = Event.find_specific(params[:id])
  erb :"/display_object"
end

get "/events/:id/edit" do
  @object = Event.find_specific(params[:id])
  erb :"/edit"  
end

get "/events/:id/update" do
  @object = Event.find_specific(params[:id])
  @object.save
  binding.pry # YOU ARE WORKING HERE!!!!!!!!!!
  redirect :"/events/#{@object.id}"
end

get "/events/:id/confirm" do
  @object = Event.find_specific(params[:id])
  erb :"/confirm"
end

get "/events/:id/delete" do
  @object = Event.find_specific(params[:id])
  @object.delete
  redirect :"/events"  
end