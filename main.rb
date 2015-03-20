require 'rubygems'
require 'bundler/setup'


require 'pry'
require 'imdb'

# setup for gem
require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "5su6tan6prmdssxst2q9xgv6"

require 'active_support'
require 'active_support/Inflector'
require 'active_support/core_ext/date_time/conversions'
require 'sinatra'
require 'sinatra/activerecord'

Bundler.require(:default)

configure :development do
  require 'sqlite3'
  set :database, {adapter: "sqlite3", database: "database/reel_bad.db"}
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'])
 ActiveRecord::Base.establish_connection(
 :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
 :host => db.host,
 :username => db.user,
 :password => db.password,
 :database => db.path[1..-1],
 :encoding => 'utf8'
 )
end

require_relative 'database/db_setup.rb'


require_relative 'modules/instance_module'
require_relative 'modules/class_module'
require_relative 'modules/date_time_module'
include Date_Time_Methods
require_relative 'helpers/route_helpers_module'
include RouteHelpers

require_relative 'models/film.rb'
require_relative 'models/event.rb'
require_relative 'models/drink.rb'
require_relative 'models/patron.rb'

require_relative "controllers/index_controller.rb"
require_relative "controllers/films_controller.rb"
require_relative "controllers/events_controller.rb"
require_relative "controllers/drinks_controller.rb"
require_relative "controllers/patrons_controller.rb"
require_relative "controllers/login_controller.rb"

