require 'sqlite3'

DATABASE = SQLite3::Database.new("reel_bad.db")

DATABASE.execute("INSERT INTO patrons (first_name, last_name, username, password) VALUES
                  ('Skyler', 'Sidner', 'malevolentdragon', '00000'),
                  ('John', 'Doe', 'JohnD', '00000'),
                  ('Jane', 'Doe', 'JaneD', '00000'),
                  ('John Jacob Jingle Heimer', 'Schmidt', 'JJHS', '00000'),
                  ('Abraham', 'Lincoln', 'HonestAbe', '00000'),
                  ('Some', 'Body', 'Adimin', '12345')")
                            
DATABASE.execute("INSERT INTO films (title, year, length, synopsis, 
                  trailer, rt_rating) VALUES
                  ('I Know Who Killed Me', 2007, 106, 
                  'A young girl who was missing reappears, 
                  but she claims to be someone else entirely.', 
                  'https://www.youtube.com/watch?v=6LaOV87bBmY', 7),
                  ('Rock n Roll Nightmare', 1987, 83,
                  'A hair metal band experiences evil things while 
                  practicing that only their lead singer can stand up 
                  against.', 
                  'https://www.youtube.com/watch?v=sXYzxiS3KrY', 0),
                  ('They Live!', 1988, 97, 
                  'A wandering vagabond discovers that the world is 
                  is being taken over by aliens and it is up to him 
                  to save it.', 
                  'https://www.youtube.com/watch?v=iJC4R1uXDaE', 83),
                  ('The Wicker Man', 2006, 106, 
                  'A police sergeant is sent to a Scottish island 
                  village in search of a missing girl whom the 
                  townsfolk claim never existed.', 
                  'https://www.youtube.com/watch?v=tlvqLOo6apM', 15), 
                  ('Santa Claus Conquers the Martians', 1964, 81, 
                  'The Martians kidnap Santa because there is nobody 
                  on Mars to give their children presents.', 
                  'https://www.youtube.com/watch?v=HnEJrwYXXsI', 25)")

msg1 = "Are you ready to ROCK? It's a ROCK 'N ROLL NIGHTMARE! Since this movie 
        rocks way too hard for a trailer, I bring you some tone-setting music 
        instead: https://www.youtube.com/watch?v=43bWpRgSdUA"
      
msg2 = "You thought you were safe.  You thought the reel bad nights were 
        over.  You were wrong.  THEY LIVE!"
      
msg3 = "Join us for a terrifying night of murder, mystery and mean girls.  
        You can try to get away with it, but I KNOW WHO KILLED ME!"

msg4 = "Shake off that turkey coma and bandage up your Black Friday trample 
        wounds, it's motherfucking Christmas time!  We're watching Santa Claus 
        Conquers the Martians!"
        
# Time/date insertions need someone else' eyes; not sure if I'm doing this right.

DATABASE.execute("INSERT INTO events (start_time, 
                  current_event, film_id, host_msg) VALUES
                  ('2014-06-06-20-00', 0, 2, ?)", "#{msg1}")

DATABASE.execute("INSERT INTO events (start_time, 
                  current_event, film_id, host_msg) VALUES
                  ('2014-09-05-20-00', 0, 3, ?)", "#{msg2}")
                  
DATABASE.execute("INSERT INTO events (start_time, 
                  current_event, film_id, host_msg) VALUES
                  ('2014-10-03-20-00', 1, 1, ?)", "#{msg3}")
                  
DATABASE.execute("INSERT INTO events (start_time, 
                  current_event, film_id, host_msg) VALUES
                  ('2014-12-05-20-00', 2, 5, ?)", "#{msg4}")

DATABASE.execute("INSERT INTO drinks (name, category, description, event_id) VALUES 
                  ('Egg Nog', 'cocktail', 'Sweetened dairy-based drink, 
                  with rum', 4),
                  ('Ruby Red', 'cocktail', 'Cranberry juice, peach 
                  schnapps, triple sec', 3),
                  ('Blue Sapphire', 'martini', 'Lime juice, blue 
                  curacao', 3),
                  ('Bubble Trouble', 'cocktail', 'Bubble-gum vodka, 
                  club soda, grenadine', 2),
                  ('The Triton', 'cocktail', 'Gin, Lillet Blanc, 
                  triple sec, orange bitters, sparkling wine', 1)")
                            
DATABASE.execute("INSERT INTO events_patrons (event_id, patron_id) VALUES 
                  (1, 1),
                  (1, 2),
                  (1, 3),
                  (1, 4),
                  (2, 1),
                  (2, 3),
                  (3, 1),
                  (3, 2),
                  (3, 5),
                  (4, 2),
                  (4, 3),
                  (4, 5)")
                            