require 'pry'
require 'rotten-tomatoes'

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

# enable :sessions

["/new/*", "/search/*"].each do |path|
  before path do
    @table = ""
    @fields = []
    if params[:splat] == ["e"]
      @fields = ["date", "doors_open", "start_time", "current_event", 
                "film_id", "host_msg"]
      @table = "events"
    elsif params[:splat] == ["p"]
      @fields = ["first_name", "last_name"]
      @table = "patrons"
    elsif params[:splat] == ["d"]
      @fields = ["name", "type", "description", "event_id"]
      @table = "drinks"
    else params[:splat] == ["f"]
      @fields = ["title", "year", "length", "synopsis", "trailer", "rt_rating"]
      @table = "films"
    end #if
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
  # # DECIDED HASH WAS EASIER THAN OBJECT FOR THIS
  # # Use Active Support to capture the right object.
  # object_type = (params[:table].classify).constantize
  # results = object_type.search(params[:table], params[:field], params[:value])
  
  @results = DATABASE.execute("SELECT * FROM #{params[:table]} WHERE #{params[:field]}='#{params[:value]}'")
  erb :results
end

get "/new/*" do
  erb :new
end

get "/confirm" do
  @table = params.delete("table")
  @info = params
  erb :confirm
end

get "/save" do
  object_type = (params["table"].classify).constantize
  @table = params.delete("table")
  @info = params
  object = object_type.new(params)
  binding.pry
  @id = object.insert
  erb :save
end




