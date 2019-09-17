# frozen_string_literal: true

class VolunteerHoursController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    current_user.volunteer_hours.create(volunteer_hour_params.merge(event_id: event.id, status: 'requested'))
    redirect_to event_path(event)
  end

  def new
    @volunteer_hour = VolunteerHour.new
  end

  private

  def volunteer_hour_params
    params.require(:volunteer_hour).permit(:time_worked)
  end
end
