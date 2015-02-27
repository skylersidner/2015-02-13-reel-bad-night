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
# require_relative "controllers/manipulate_controller.rb"
# require_relative "controllers/finalize_controller.rb"

require_relative "controllers/events_controller.rb"
require_relative "controllers/films_controller.rb"
require_relative "controllers/patrons_controller.rb"
require_relative "controllers/drinks_controller.rb"





