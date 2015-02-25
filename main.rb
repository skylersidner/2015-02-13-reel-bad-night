require 'pry'
require 'imdb'

# setup for gem
require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "5su6tan6prmdssxst2q9xgv6"

require 'active_support'
require 'active_support/Inflector'
require 'sinatra'

require_relative 'database/db_setup.rb'

require_relative 'modules/instance_module'
require_relative 'modules/class_module'
require_relative 'helpers/route_helpers_module'
include RouteHelpers

require_relative 'models/film.rb'
require_relative 'models/event.rb'
require_relative 'models/drink.rb'
require_relative 'models/patron.rb'

require_relative "controllers/index_controller.rb"
require_relative "controllers/manipulate_controller.rb"
require_relative "controllers/finalize_controller.rb"



enable :sessions
set :session_secret, 'optimus'

["/new/*", "/search/*", "/edit/*", "/remove/*"].each do |path|
  before path do #set relevant fields array for dropdown
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
    
    
    #flag for current set of operations
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





