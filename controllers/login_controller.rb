enable :sessions

def no_user
  session[:user] = Patron.new("username" => "Not Logged In")
  @user = session[:user]
end

def check_for_admin
  if session[:user].username != "Admin"
    redirect "/login"
  end
end

before "/*" do
  @user = session[:user]
end

["/*/:id/edit"].each do |path|
  before path do
    check_for_admin
  end
end

get "/login" do
  if session[:user].username == "Admin"
    redirect "/patrons/#{session[:user].id}/show"
  end
  erb :"/login/login"
end

post "/validate" do
  @user = Patron.get_user(params[:username])
  if @user == nil || @user.password != params[:password]
    redirect "/failed"
  end
  session[:user] = @user
  erb :"/login/validated"
end

get "/failed" do
  erb :"/login/failed"
end

get "/logout" do
  no_user
  redirect "/"
end