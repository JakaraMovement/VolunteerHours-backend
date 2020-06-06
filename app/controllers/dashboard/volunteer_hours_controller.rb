class Dashboard::VolunteerHoursController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    time_worked = calc_time(params[:hours_worked],params[:minutes_worked])
    current_user.volunteer_hours.create(time_worked: time_worked, event_id: event.id, status: VolunteerHour::REQUESTED)
    redirect_to dashboard_event_path(event)
  end

  def new
    @volunteer_hour = VolunteerHour.new
  end

  def calc_time(hours, minutes)
    (hours.to_f + minutes.to_f/60).truncate(2)
  end
end
