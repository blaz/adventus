module ApplicationHelper
  def due(arrival)
    return 'Due' if arrival.time_to_station < 60

    now = Time.zone.now
    distance_of_time_in_words(now, now + arrival.time_to_station)
  end
end
