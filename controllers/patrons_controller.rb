["/patrons", "/patrons/*"].each do |path|
  before path do
    @title = "Patrons"
    @table = ["id", "first_name", "last_name"]
  end
end


get "/patrons" do
  @results = Patron.all
  erb :"/display_results"
end

get "/patrons/new" do
  create_blank_fields_hash #helper
  @object = Patron.new(@blank_fields_hash) #populate fields
  erb :"/new"
end

get "/patrons/save" do
  @new = Patron.new(params)
  @new.insert
  redirect :"/patrons/#{@new.id}/show"
end

get "/patrons/search" do
  erb :"/search"
end

get "/patrons/search_results" do
  get_search_results #helper
  erb :"/display_results"
end

get "/patrons/:id/show" do
  @object = Patron.find_specific(params[:id])
  erb :"/display_object"
end

get "/patrons/:id/edit" do
  @object = Patron.find_specific(params[:id])
  erb :"/edit"  
end

get "/patrons/:id/update" do
  @object = Patron.new(params)
  @object.save
  redirect :"/patrons/#{@object.id}/show"
end

get "/patrons/:id/confirm" do
  @object = Patron.find_specific(params[:id])
  erb :"/confirm"
end

get "/patrons/:id/delete" do
  @object = Patron.find_specific(params[:id])
  @object.delete
  redirect :"/patrons"  
end