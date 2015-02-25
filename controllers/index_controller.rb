get "/" do
  # .search returns an array; this adjusts to the object, specifically
  array = Event.search("events", "current_event", 2)
  @current_event = array[0]
  array = Film.search("films", "id", "#{@current_event.film_id}")
  @current_film = array[0]
  array = Event.search("events", "current_event", 1)
  @previous_event = array[0]
  array = Film.search("films", "id", "#{@previous_event.film_id}")
  @previous_film = array[0]
  erb :"index/homepage"
end