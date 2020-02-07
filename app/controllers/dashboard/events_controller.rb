class Dashboard::EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.order(:start_time)
  end

  def filter_events
    region_id = params[:region_id]
    if region_id.present?
      @events = Event.where(region_id: region_id).order(:start_time)
    elsif params[:past_events]
      @events = Event.where('end_time < ?', Time.now).order(:start_time)
    elsif params[:upcoming_events]
      @events = Event.where('end_time >= ?', Time.now).order(:start_time)
    else
      @events = Event.order(:start_time)
    end

    respond_to do |format|
      format.html { render action: :index }
      format.js {}
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_volunteer_hour = @event.volunteer_hours.where(user_id: current_user&.id).first
    @comment = Comment.new
    @volunteer_hour = VolunteerHour.new
  end
end
