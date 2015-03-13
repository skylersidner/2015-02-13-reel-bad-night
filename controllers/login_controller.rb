get "/login" do
  erb :"/login/login"
end

post "/validate" do
  @user = Patron.get_user(params[:username])
  if @user == nil || @user.password != params[:password]
    redirect :"/failed"
  end
  erb :"/login/validated"
end

get "/failed" do
  erb :"/login/failed"
end