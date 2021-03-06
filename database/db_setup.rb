# require 'sqlite3'
# DATABASE = SQLite3::Database.new("database/reel_bad.db")

unless ActiveRecord::Base.connection.table_exists?(:films)
  ActiveRecord::Base.connection.create_table :films do |t|
    t.text :title
    t.integer :year
    t.integer :length
    t.text :synopsis
    t.text :trailer
    t.integer :rt_rating
  end
end

# DATABASE.execute("CREATE TABLE IF NOT EXISTS films
#                  (id INTEGER PRIMARY KEY,
#                  title TEXT NOT NULL,
#                  year INTEGER NOT NULL CHECK (year >= 1900),
#                  length INTEGER NOT NULL CHECK(length >= 0),
#                  synopsis TEXT NOT NULL,
#                  trailer TEXT,
#                  rt_rating INTEGER)")

unless ActiveRecord::Base.connection.table_exists?(:events)
  ActiveRecord::Base.connection.create_table :events do |t|
    t.text :start_time
    t.text :host_msg
    t.integer :current_event
    t.integer :film_id    
  end
end

# DATABASE.execute("CREATE TABLE IF NOT EXISTS events
#                  (id INTEGER PRIMARY KEY,
#                  start_time TEXT NOT NULL,
#                  host_msg TEXT,
#                  current_event INTEGER,
#                  film_id INTEGER,
#                  FOREIGN KEY (film_id) REFERENCES films(id))")

unless ActiveRecord::Base.connection.table_exists?(:drinks)
  ActiveRecord::Base.connection.create_table :drinks do |t|
    t.text :name
    t.text :category
    t.text :description
    t.integer :event_id    
  end
end

# DATABASE.execute("CREATE TABLE IF NOT EXISTS drinks
#                  (id INTEGER PRIMARY KEY,
#                  name TEXT NOT NULL,
#                  category TEXT NOT NULL,
#                  description TEXT,
#                  event_id INTEGER,
#                  FOREIGN KEY (event_id) REFERENCES events(id))")

unless ActiveRecord::Base.connection.table_exists?(:patrons)
  ActiveRecord::Base.connection.create_table :patrons do |t|
    t.text :first_name
    t.text :last_name
    t.text :username
    t.text :password    
  end
end

# DATABASE.execute("CREATE TABLE IF NOT EXISTS patrons
#                   (id INTEGER PRIMARY KEY,
#                   first_name TEXT NOT NULL,
#                   last_name TEXT NOT NULL,
#                   username TEXT NOT NULL,
#                   password TEXT NOT NULL)")

unless ActiveRecord::Base.connection.table_exists?(:events_patrons)
  ActiveRecord::Base.connection.create_table :events_patrons do |t|
    t.integer :event_id
    t.integer :patron_id 
  end
end

# DATABASE.execute("CREATE TABLE IF NOT EXISTS events_patrons
#                  (event_id INTEGER NOT NULL,
#                  patron_id INTEGER NOT NULL,
#                  FOREIGN KEY (event_id) REFERENCES events(id),
#                  FOREIGN KEY (patron_id) REFERENCES patrons(id))")
#
# DATABASE.results_as_hash = true

