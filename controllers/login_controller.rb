enable :sessions

def no_user
  @user = Patron.find_by id: 2
  session[:user] = 2
end

def check_for_admin
  if session[:user] != 1
    redirect "/login"
  end
end

before "/*" do
  if session[:user] >= 1 && session[:user] <= 7
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
  if session[:user] >= 1 && session[:user] <= 7 && session[:user] != 2
    redirect "/patrons/#{session[:user]}/show"
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