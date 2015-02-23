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
require_relative 'modules/route_helpers_module'
include ErbHelpers

require_relative 'models/film.rb'
require_relative 'models/event.rb'
require_relative 'models/drink.rb'
require_relative 'models/patron.rb'


require 'sinatra'

enable :sessions
set :session_secret, 'voltron'

["/new/*", "/search/*", "/edit/*", "/remove/*"].each do |path|
  before path do
    if params[:splat] == ["e"]
      session[:fields] = ["date", "doors_open", "start_time", "current_event", "film_id", "host_msg"]
      session[:table] = "events"
      session[:film] = false
    elsif params[:splat] == ["p"]
      session[:fields] = ["first_name", "last_name"]
      session[:table] = "patrons"
      session[:film] = false
    elsif params[:splat] == ["d"]      
      session[:fields] = ["name", "type", "description", "event_id"]
      session[:table] = "drinks"
      session[:film] = false
    else params[:splat] == ["f"]
      session[:fields] = ["title", "year", "length", "synopsis", "trailer", "rt_rating"]
      session[:table] = "films"
      session[:film] = true
    end #if params
    
    if path == "/new/*"
      session[:new] = true
    else
      session[:new] = false
    end
    
    if path == "/remove/*"
      session[:remove] = true
    else
      session[:remove] = false
    end
    
    if path == "/edit/*"
      session[:edit] = true
    else
      session[:edit] = false
    end
    
  end #before path
end #each

get "/" do
  # .search returns an array; this adjusts to the object, specifically
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
  if params[:all] == "yes" #check if they want all of that type
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
  object_class = (session[:table].classify).constantize #capture object type
  create_blank_fields_hash #helper
  @object = object_class.new(@blank_fields_hash) #populate the fields blank
  
  if params.length != 0 #check to see if a page is passing object info
    @object = object_class.new(params)
  end
  erb :new
end

get "/new_film_rt" do
  @results = []
  @thumbs = []
  if params[:search] != nil
    
    search_results = RottenMovie.find(:title => "#{params[:search]}", :limit => 20)
    if search_results.length == nil #check if search returned a single object
      search_results = [search_results] #make it an array
    end
    search_results.each do |x| #capture relevant info from rottentomatoes
      film = Film.new("title"=>"#{x.title}", "year"=>"#{x.year}", "length"=>"#{x.runtime}", "synopsis"=>"#{x.synopsis}", "trailer"=>"", "rt_rating"=>"#{x.ratings.critics_score}")
      @results << film

      thumb = x.posters.thumbnail #capture an image of the poster
      if thumb == nil #if there isn't one, use default
        thumb = "/Users/skylersidner/Code/2015-02-13-reel-bad-night/public/images/poster_default.gif"
      end
      if thumb.include?("tmb") #minor adjustment for better image, if possible
        thumb.slice!("tmb")
        thumb.insert(-5, "det")
      end
      @thumbs << thumb
    end

  end
  erb :new_film_rt
end

get "/confirm" do
  @results = []
  @info = params
  
  if params[:edit] == "yes"
    erb :edit
  end
  
  if params[:rt] == "yes" #check if they are using rottentomatoes
    redirect to("/new_film_rt")
  end
  
  if session[:remove] == true && session[:table] != "events"
    @results = Event.search("events", "film_id", params[:id])
  end

  erb :confirm
end

get "/save" do
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
  erb :save
end

get "/remove/*" do  
  erb :search
end

get "/edit/*" do
  erb :search
end

