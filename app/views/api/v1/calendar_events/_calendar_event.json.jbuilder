json.startTime Time.at(calendar_event.from).iso8601
json.endTime Time.at(calendar_event.to).iso8601
json.busySlot calendar_event.busy_slot > calendar_event.total_slot ? calendar_event.total_slot : calendar_event.busy_slot
json.totalSlot calendar_event.total_slot
