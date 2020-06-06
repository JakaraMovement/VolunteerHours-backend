module Admin::EventsHelper
  def hours_volunteered( volunteer_id, event_id )
    VolunteerHour.find_by(user_id: volunteer_id, event_id: event_id)&.time_worked
  end
  
  def pending_volunteer_hours_review?( event )
    event.volunteer_hours.exists?(status: VolunteerHour::REQUESTED)
  end
end