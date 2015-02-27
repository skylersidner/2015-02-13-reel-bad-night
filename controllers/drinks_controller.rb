["/drinks", "/drinks/*"].each do |path|
  before path do
    @title = "Drinks"
    @table = ["id", "name", "type", "description", "event_id"]
  end
end


get "/drinks" do
  @results = Drink.all
  erb :"/display_results"
end

get "/drinks/new" do
  create_blank_fields_hash #helper
  @object = Drink.new(@blank_fields_hash) #populate fields
  erb :"/new"
end

get "/drinks/save" do
  @new = Drink.new(params)
  @new.insert
  redirect :"/drinks/#{@new.id}/show"
end

get "/drinks/search" do
  erb :"/search"
end

get "/drinks/search_results" do
  get_search_results #helper
  @admin = true
  erb :"/display_results"
end

get "/drinks/:id/show" do
  @object = Drink.find_specific(params[:id])
  erb :"/display_object"
end

get "/drinks/:id/edit" do
  @object = Drink.find_specific(params[:id])
  erb :"/edit"  
end

get "/drinks/:id/update" do
  @object = Drink.new(params)
  @object.save
  redirect :"/drinks/#{@object.id}/show"
end

get "/drinks/:id/confirm" do
  @object = Drink.find_specific(params[:id])
  erb :"/confirm"
end

get "/drinks/:id/delete" do
  @object = Drink.find_specific(params[:id])
  @object.delete
  redirect :"/drinks"  
end