class Dashboard::EventsController < ApplicationController
  before_action :authenticate_user!
  include Pagy::Backend

  def index
    @pagy, @events = pagy(Event.order(start_time: :desc))
  end

  def filter_events
    region_id = params[:region_id]
    if region_id.present?
      @pagy, @events = pagy(Event.where(region_id: region_id).order(start_time: :desc))
    elsif params[:past_events]
      @pagy, @events = pagy(Event.where('end_time < ?', Time.now).order(start_time: :desc))
    elsif params[:upcoming_events]
      @pagy, @events = pagy(Event.where('end_time >= ?', Time.now).order(:start_time))
    else
      @pagy, @events = pagy(Event.order(start_time: :desc))
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
      items: vars[:items] || 8,
      i18n_key: item_name
    }
  end
end
