get "/login" do
  erb :"/login/login"
end

post "/validate" do
  @user = Patron.get_user(params[:username])
  if @user.password != params[:password] || @user == nil
    @invalid = true
    redirect :"/validate"
  end
  erb :"/login/validated"
end