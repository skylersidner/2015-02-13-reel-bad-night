["/patrons", "/patrons/*"].each do |path|
  before path do
    @title = "Patrons"
    @table = ["id", "first_name", "last_name", "username", "password"]
  end
end


get "/patrons" do
  @results = Patron.all
  erb :"/display/display_patrons"
end

get "/patrons/new" do
  create_blank_fields_hash #helper
  @object = Patron.new(@blank_fields_hash) #populate fields
  erb :"/manipulate/new"
end

post "/patrons/save" do
  @new = Patron.create(params)
  redirect "/patrons/#{@new.id}/show"
end

get "/patrons/search" do
  erb :"/index/search"
end

get "/patrons/search_results" do
  @results = Patron.where params[:search_field]=> params[:value]
  erb :"/display/display_patrons"
end

get "/patrons/:id/show" do
  @object = Patron.find_by_id(params[:id])
  erb :"/display/display_patron"
end

get "/patrons/:id/edit" do
  @object = Patron.find_by_id(params[:id])
  erb :"/manipulate/edit_patron"  
end

post "/patrons/:id/update" do
  @object = Patron.find_by_id(params[:id])
  @object.update(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], password: params[:password])
  redirect "/patrons/#{@object.id}/show"
end

get "/patrons/:id/confirm" do
  @object = Patron.find_by_id(params[:id])
  erb :"/manipulate/confirm_patron"
end

post "/patrons/:id/delete" do
  @object = Patron.find_by_id(params[:id])
  @object.destroy
  redirect "/patrons"  
end