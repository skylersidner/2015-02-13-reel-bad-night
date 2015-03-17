get "/" do
  @current_event = Event.find_by current_event: 2
  # array = Event.search("current_event", 2)
  # @current_event = array[0]
  @current_film = Film.find_by id: @current_event.film_id
  # array = Film.search("id", "#{@current_event.film_id}")
  # @current_film = array[0]
  @previous_event = Event.find_by current_event: 1
  # array = Event.search("current_event", 1)
  # @previous_event = array[0]
  @previous_film = Film.find_by id: @previous_event.film_id
  # array = Film.search("id", "#{@previous_event.film_id}")
  # @previous_film = array[0]
  erb :"index/homepage"
end