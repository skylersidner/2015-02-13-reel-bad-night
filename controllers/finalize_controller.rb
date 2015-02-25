get "/results/*" do
  # Use Active Support to capture the right class.
  object_class = (session[:table].classify).constantize
  if params[:all] == "yes" #check if they want all of that type
    @results = object_class.all(session[:table])
  else
    @results = object_class.search(session[:table], params[:search_field], params[:value])
  end

  erb :"finalize/results"
end

get "/confirm/*" do
  @results = []
  @info = params
  
  if params[:rt] == "yes" #check if they are using rottentomatoes
    redirect to("/new_film_rt/f")
  end
  
  if params[:edit] == "yes" #check if they are editing
    erb :"manipulate/edit"
  end
  
  #check if they are removing and there is an associated event
  if session[:remove] == true && session[:table] != "events"
    @results = Event.search("events", "film_id", params[:id])
  end

  erb :"finalize/confirm"
end

get "/save/*" do
  object_class = (session[:table].classify).constantize
  object = object_class.new(params)
  
  if session[:remove] == true
    object.delete(session[:table])
    session[:remove] = false
  elsif session[:new] == true
    params[:id] = object.insert
    session[:new] = false
  elsif session[:edit] == true
    object.save(session[:table])
    session[:edit] = false
  end

  @info = params
  erb :"finalize/save"
end