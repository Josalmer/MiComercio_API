json.events @events do |event|
  json.partial! 'api/v1/calendar_events/calendar_event', calendar_event: event
end
