["/events", "/events/*"].each do |path|
  before path do
    @title = "Events"
    @table = ["id", "start_time", "film_id", "host_msg", "current_event"]
  end
end


get "/events" do
  @results = Event.all
  # @results.each do |x|
  #   x.prepare_for_display
  # end
  erb :"/display/display_events"
end

get "/events/new" do
  create_blank_fields_hash #helper
  @object = Event.new(@blank_fields_hash) #populate fields
  erb :"/manipulate/new"
end

post "/events/save" do
  @new = Event.create(params)
  redirect "/events/#{@new.id}/show"
end

get "/events/search" do
  erb :"/index/search"
end

get "/events/search_results" do
  @results = Event.where params[:search_field]=> params[:value]
  # @results.each do |x|
  #   x.prepare_for_display
  # end
  erb :"/display/display_events"
end

get "/events/:id/show" do
  @object = Event.find_by id: params[:id]
  # @object.prepare_for_display
  erb :"/display/display_event"
end

get "/events/:id/edit" do
  @object = Event.find_by id: params[:id]
  erb :"/manipulate/edit_event"  
end

post "/events/:id/update" do
  @object = Event.find_by id: params[:id]
  @object.update(start_time: params[:start_time], film_id: params[:film_id], host_msg: params[:host_msg], current_event: params[:current_event])
  redirect "/events/#{@object.id}/show"
end

get "/events/:id/confirm" do
  @object = Event.find_by id: params[:id]
  erb :"/manipulate/confirm_event"
end

post "/events/:id/delete" do
  @object = Event.find_by id: params[:id]
  @object.destroy
  redirect "/events"  
end