class Dashboard::EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @regions = Region.all
    @events_filter = EventsFilter.new(events_filter_params)
    if @events_filter.region.present?
      @events = Event.where(region_id: @events_filter.region)
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_volunteer_hour = @event.volunteer_hours.first
    @comment = Comment.new
    @volunteer_hour = VolunteerHour.new
  end

  private

  def events_filter_params
    params.fetch(:events_filter, {}).permit(
      :region
    )
  end
end
