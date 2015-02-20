require 'pry'
require 'imdb'

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

      if path == "/new/*"
        redirect to("/new_film")
      end
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
  # Use Active Support to capture the right class.
  object_class = (params[:table].classify).constantize
  if params[:all] == "yes"
    @results = object_class.all(params[:table])
  else
    @results = object_class.search(params[:table], params[:field], params[:value])
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
  # Necessary for now; redirect looses this;
  @fields = ["title", "year", "length", "synopsis", "trailer", "rt_rating"]
  @table = "films"
  erb :new_film
end

get "/new_film_imdb" do
  @results = []
  if params[:search] != nil
    search = Imdb::Search.new("#{params[:search]}")
    @results = search.movies
  end
  

  binding.pry
  erb :new_film_imdb
end

get "/confirm" do
  if params[:imdb] == "yes"
    redirect to("/new_film_imdb")
  end
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




