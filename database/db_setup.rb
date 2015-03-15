require 'sqlite3'

DATABASE = SQLite3::Database.new("database/reel_bad.db")

DATABASE.execute("CREATE TABLE IF NOT EXISTS films
                 (id INTEGER PRIMARY KEY,
                 title TEXT NOT NULL,
                 year INTEGER NOT NULL CHECK (year >= 1900),
                 length INTEGER NOT NULL CHECK(length >= 0),
                 synopsis TEXT NOT NULL,
                 trailer TEXT,
                 rt_rating INTEGER)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS events
                 (id INTEGER PRIMARY KEY,
                 start_time TEXT NOT NULL,
                 host_msg TEXT,
                 current_event INTEGER,
                 film_id INTEGER,
                 FOREIGN KEY (film_id) REFERENCES films(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS drinks
                 (id INTEGER PRIMARY KEY,
                 name TEXT NOT NULL,
                 category TEXT NOT NULL,
                 description TEXT,
                 event_id INTEGER,
                 FOREIGN KEY (event_id) REFERENCES events(id))")


DATABASE.execute("CREATE TABLE IF NOT EXISTS patrons
                  (id INTEGER PRIMARY KEY,
                  first_name TEXT NOT NULL,
                  last_name TEXT NOT NULL,
                  username TEXT NOT NULL,
                  password TEXT NOT NULL)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS events_patrons
                 (event_id INTEGER NOT NULL,
                 patron_id INTEGER NOT NULL,
                 FOREIGN KEY (event_id) REFERENCES events(id),
                 FOREIGN KEY (patron_id) REFERENCES patrons(id))")

DATABASE.results_as_hash = true

