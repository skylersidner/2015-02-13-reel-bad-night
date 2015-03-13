enable :sessions
# session[:user] => "Not Logged In"

# def current_user
#   if there_is_a_logged_in_user
#     @current_user = User.find(the_logged_in_user_id)
#   else
#     redirect "/login"
#   end
# end



get "/login" do
  erb :"/login/login"
end

post "/validate" do
  @user = Patron.get_user(params[:username])
  if @user == nil || @user.password != params[:password]
    redirect "/failed"
  end
  session[:user] = @user.username
  erb :"/login/validated"
end

get "/failed" do
  erb :"/login/failed"
end