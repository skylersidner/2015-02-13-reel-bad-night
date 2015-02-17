require 'sqlite3'

DATABASE = SQLite3::Database.new("database/reel_bad.db")

DATABASE = DATABASE.execute("INSERT INTO patrons (first_name, last_name) VALUES
                            ('Skyler', 'Sidner'),
                            ('John', 'Doe'),
                            ('Jane', 'Doe'),
                            ('John Jacob Jingle Heimer', 'Schmidt'),
                            ('Abraham', 'Lincoln')")
                            
DATABASE = DATABASE.execute("INSERT INTO films (title, year, length, synopsis, 
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

# Not sure quite how to make this work.  Will feed info for now. BROKEN

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

DATABASE = DATABASE.execute("INSERT INTO events (date, doors_open, start_time, 
                            host_msg, film_id) VALUES 
                            ('2014-06-06', 19:30, 20:00, '#{msg1}', 2),
                            ('2014-09-05', 19:30, 20:00, '#{msg2}', 3),
                            ('2014-10-03', 19:30, 20:00, '#{msg3}', 1),
                            ('2014-12-05', 19:00, 20:00, '#{msg4}', 4)")
                            
DATABASE = DATABASE.execute("INSERT INTO drinks (name, type, description, 
                            film_id) VALUES 
                            ('Egg Nog', 'cocktail', 'Sweetened dairy-based drink, 
                            with rum', 4),
                            ('Ruby Red', 'cocktail', 'Cranberry juice, peach 
                            schnapps, triple sec', 3),
                            ('Blue Sapphire', 'martini', 'Lime juice, blue 
                            curacao, 3),
                            ('Bubble Trouble', 'cocktail', 'Bubble-gum vodka, 
                            club soda, grenadine', 2),
                            ('The Triton', 'cocktail', 'Gin, Lillet Blanc, 
                            triple sec, orange bitters, sparkling wine', 1)")
                            
                            
                            