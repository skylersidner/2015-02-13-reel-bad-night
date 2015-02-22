require 'pry'
require 'imdb'

# setup for gem
require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "5su6tan6prmdssxst2q9xgv6"

require 'active_support'
require 'active_support/Inflector'

require_relative 'db_setup.rb'

require_relative 'modules/instance_module'
require_relative 'modules/class_module'

require_relative 'models/film.rb'
require_relative 'models/event.rb'
require_relative 'models/drink.rb'
require_relative 'models/patron.rb'


require 'sinatra'

enable :sessions
set :session_secret, 'voltron'

["/new/*", "/search/*", "/remove/*"].each do |path|
  before path do
    if params[:splat] == ["e"]
      session[:fields] = ["date", "doors_open", "start_time", "current_event", "film_id", "host_msg"]
      session[:table] = "events"
    elsif params[:splat] == ["p"]
      session[:fields] = ["first_name", "last_name"]
      session[:table] = "patrons"
    elsif params[:splat] == ["d"]      
      session[:fields] = ["name", "type", "description", "event_id"]
      session[:table] = "drinks"
    else params[:splat] == ["f"]
      session[:fields] = ["title", "year", "length", "synopsis", "trailer", "rt_rating"]
      session[:table] = "films"

      if path == "/new/*"
        redirect to("/new_film")
      end #if path      
    end #if params
    
    if path == "/remove/*"
      session[:remove] = true
    else
      session[:remove] = false
    end #if path
  end #before 
end #each

get "/" do
  array = Event.search("events", "current_event", 2)
  @current_event = array[0]
  array = Film.search("films", "id", "#{@current_event.film_id}")
  @current_film = array[0]
  array = Event.search("events", "current_event", 1)
  @previous_event = array[0]
  array = Film.search("films", "id", "#{@previous_event.film_id}")
  @previous_film = array[0]
  erb :homepage
end

get "/search/*" do
  erb :search
end

get "/results" do
  # Use Active Support to capture the right class.
  object_class = (session[:table].classify).constantize
  if params[:all] == "yes"
    @results = object_class.all(session[:table])
  else
    @results = object_class.search(session[:table], params[:search_field], params[:value])
  end

  if @results.count == 0
    redirect to("/no_results")
  end
  erb :results
end

get "/no_results" do
  erb :no_results
end

get "/new/*" do
  erb :new
end

get "/new_film" do
  @film = Film.new("title"=>"", "year"=>"", "length"=>"", "synopsis"=>"", "trailer"=>"", "rt_rating"=>"")
  if params.length != 0
    @film = Film.new(params)
  end
  erb :new_film
end

get "/new_film_rt" do
  @results = []
  if params[:search] != nil
    
    search = RottenMovie.find(:title => "#{params[:search]}", :limit => 20)
    if search.length == nil
      search = [search]
    end
    search.each do |x|
      film = Film.new("title"=>"#{x.title}", "year"=>"#{x.year}", "length"=>"#{x.runtime}", "synopsis"=>"#{x.synopsis}", "trailer"=>"", "rt_rating"=>"#{x.ratings.critics_score}")
      @results << film
    end 
    
    # # Old functionality for IMDB searching I may use in the future
    # search = Imdb::Search.new("#{params[:search]}")
    # @results = search.movies
  end
  erb :new_film_rt
end

get "/confirm" do
  @results = []
  if params[:rt] == "yes"
    redirect to("/new_film_rt")
  end
  @info = params
  
  if session[:remove] == true && session[:table] != "events"
    @results = Event.search("events", "film_id", params[:id])
  end

  binding.pry
  erb :confirm
end

get "/save" do
  object_class = (session[:table].classify).constantize
  object = object_class.new(params)
  
  if session[:remove] == true
    object.delete(session[:table], params["id"])
  else
    @id = object.insert
    params[:id] = "#{@id}"
  end

  @info = params
  erb :save
end

get "/remove/*" do  
  erb :search
end



