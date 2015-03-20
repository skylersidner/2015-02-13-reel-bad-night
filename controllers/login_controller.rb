enable :sessions

def no_user
  session[:user] = nil
  @user = nil
end

def check_for_admin
  @user = Patron.find_by id: session[:user]
  if @user.username != "Admin"
    redirect "/login"
  end
end

before "/*" do
  if session[:user] != nil
    @user = Patron.find_by id: session[:user]
  else
    no_user
  end
end

["/*/:id/edit"].each do |path|
  before path do
    check_for_admin
  end
end

get "/login" do
  if session[:user] != nil
    no_user
  end
  erb :"/login/login"
end

post "/validate" do
  @user = Patron.find_by "username" => params[:username]
  if @user == nil || @user.password != params[:password]
    redirect "/failed"
  end
  session[:user] = @user.id
  erb :"/login/validated"
end

get "/failed" do
  erb :"/login/failed"
end

get "/logout" do
  no_user
  redirect "/"
end