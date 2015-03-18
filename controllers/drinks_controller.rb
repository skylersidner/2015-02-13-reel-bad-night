["/drinks", "/drinks/*"].each do |path|
  before path do
    @title = "Drinks"
    @table = ["id", "name", "category", "description", "event_id"]
  end
end


get "/drinks" do
  @results = Drink.all
  erb :"/display/display_drinks"
end

get "/drinks/new" do
  create_blank_fields_hash #helper
  @object = Drink.new(@blank_fields_hash) #populate fields
  erb :"/manipulate/new"
end

post "/drinks/save" do
  @new = Drink.create(params)
  # @new = Drink.new(params)
  # @new.insert
  redirect "/drinks/#{@new.id}/show"
end

get "/drinks/search" do
  erb :"/index/search"
end

get "/drinks/search_results" do
  @results = Drink.where params[:search_field]=> params[:value]
  # get_search_results #helper
  erb :"/display/display_drinks"
end

get "/drinks/:id/show" do
  @object = Drink.find_by id: params[:id]
  # @object = Drink.find_specific(params[:id])
  erb :"/display/display_drink"
end

get "/drinks/:id/edit" do
  @object = Drink.find_by id: params[:id]
  # @object = Drink.find_specific(params[:id])
  erb :"/manipulate/edit_drink"  
end

post "/drinks/:id/update" do
  # @object = Drink.new(name: params[:name], category: params[:category], description: params[:description], event_id: params[:event_id])
  # @object.save
  
  @object = Drink.find_by id: params[:id]
  @object.update(name: params[:name], category: params[:category], description: params[:description], event_id: params[:event_id])
  
  # @object = Drink.new(params)
  # @object.save
  redirect "/drinks/#{@object.id}/show"
end

get "/drinks/:id/confirm" do
  @object = Drink.find_by id: params[:id]
  # @object = Drink.find_specific(params[:id])
  erb :"/manipulate/confirm_drink"
end

post "/drinks/:id/delete" do
  @object = Drink.find_by id: params[:id]
  @object.destroy
  # @object = Drink.find_specific(params[:id])
  # @object.delete
  redirect "/drinks"  
end