class Admin::EventsController < AdminController
  before_action :load_event, except: %i[index create new]
  def index
    params[:active] ||= 'true'
    if params[:active].eql?('true')
      events = Event.active
      @events_title = 'Active Events'
    else
      events = Event.archived
      @events_title = 'Archived Events'
    end
    
    @pagy, @events = pagy(
      events.includes(:region)
            .search(params[:search])
            .order("#{sort_column} #{sort_direction}, events.name")
            .distinct
    )
  end

  def new
    @event = Event.new
  end

  def show
    @volunteer_events = Event.includes(:users)
                             .includes(:volunteer_hours)
                             .where(id: @event.id)
                             .order(sort_by_multiple_columns)
                             .references(:users)
                             .references(:volunteer_hours)
    @event_volunteers = @volunteer_events.first.users.where(volunteer_hours: {status: VolunteerHour::ACCEPTED})
    @total_hours_volunteered = @event.volunteer_hours.where(status: VolunteerHour::ACCEPTED).pluck(:time_worked).reduce(:+) || 0
  end

  def create
    Event.create!(event_params)
    redirect_to admin_events_path
  end

  def update
    @event.update(event_params)
    redirect_to admin_events_path
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit!
  end

  def load_event
    @event = Event.find(params[:id])
  end
end
