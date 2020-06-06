class Dashboard::EventsController < ApplicationController
  before_action :authenticate_user!
  include Pagy::Backend

  def index
    @page_title = 'All Events'
    @pagy, @events = pagy(Event.order(start_time: :desc))
  end

  def filter_events
    region_id = params[:region_id]
    if region_id.present?
      @page_title = "Events in #{Region.find(region_id).name}"
      @pagy, @events = pagy(Event.where(region_id: region_id).order(start_time: :desc))
    elsif params[:past_events]
      @page_title = 'Past Events'
      @pagy, @events = pagy(Event.where('end_time < ?', Time.now).order(start_time: :desc))
    elsif params[:upcoming_events]
      @page_title = 'Upcoming Events'
      @pagy, @events = pagy(Event.where('end_time >= ?', Time.now).order(:start_time))
    elsif params[:my_events]
      @page_title = 'My Events'
      user_event_ids = current_user.events.pluck(:id)
      @pagy, @events = pagy(Event.where(id: user_event_ids).order(start_time: :desc))
    else
      @page_title = 'All Events'
      @pagy, @events = pagy(Event.order(start_time: :desc))
    end

    respond_to do |format|
      format.html { render action: :index }
      format.js {}
    end
  end

  def show
    @comment = Comment.new
    @volunteer_hour = VolunteerHour.new
    @event = Event.find(params[:id])
    @event_volunteer_hour = @event.volunteer_hours.find_by(user_id: current_user.id)
    @page_title = "#{@event.name} in #{@event.region.name}"
  end

  private

  def pagy_get_vars(collection, vars)
    item_name = if params[:past_events].present?
      'activerecord.models.past_events'
    elsif params[:upcoming_events].present?
      'activerecord.models.upcoming_events'
    elsif params[:region_id].present?
      count = Region.find_by(id: params[:region_id])&.events&.count
      count && count > 1 ? 'activerecord.models.events' : "activerecord.models.#{Event.model_name.i18n_key}"
    else
      "activerecord.models.events"
    end

    {
      count: collection.count,
      page: params['page'],
      items: vars[:items] || 12,
      i18n_key: item_name
    }
  end
end
