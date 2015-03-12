get "/login" do
  erb :"/login/login"
end

post "/validate" do
  @user = Patron.new()
end