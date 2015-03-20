enable :sessions

def no_user
  session[:user] = nil
  @user = nil
end

def check_for_admin
  @user = Patron.find_by_id(session[:user])
  if @user.username != "Admin"
    redirect "/login"
  end
end

before "/*" do
  if session[:user].is_a?(Integer)
    @user = Patron.find_by_id(session[:user])
  else
    no_user
  end
end

["/*/:id/edit"].each do |path|
  before path do
    if session[:user].is_a?(Integer)
      check_for_admin
    else
      redirect "/login"
    end
  end
end

get "/login" do
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
  @logout = true
  erb :"/login/login"
end