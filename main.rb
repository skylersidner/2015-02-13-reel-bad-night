require 'pry'
require 'rotten-tomatoes'

require_relative 'db_setup.rb'

require_relative 'modules/instance_module'
require_relative 'modules/class_module'

require_relative 'models/film.rb'
require_relative 'models/event.rb'
require_relative 'models/drink.rb'
require_relative 'models/patron.rb'


require 'sinatra'

get "/" do
  array = Event.search("events", "current_event", 2)
  @current_event = array[0]
  array = Film.search("films", "id", "#{@current_event.id}")
  @current_film = array[0]
  array = Event.search("events", "current_event", 1)
  @previous_event = array[0]
  array = Film.search("films", "id", "#{@previous_event.id}")
  @previous_film = array[0]
  erb :homepage
end

get "/search/*" do
  @table = ""
  @fields = []
  if params[:splat] == ["e"]
    @fields = ["date", "doors_open", "start_time", "current_event", "film_id", 
              "host_msg"]
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
  end
  erb :search
end

get "/results" do
  
  erb :results
end