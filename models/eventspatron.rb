#dummy class for AR database associations functionality
class EventsPatron < ActiveRecord::Base
  belongs_to :event
  belongs_to :patron
end