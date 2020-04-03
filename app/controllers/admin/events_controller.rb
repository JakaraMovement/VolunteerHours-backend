class Admin::EventsController < AdminController
  before_action :load_event, except: %i[index create new]
  def index
    @pagy, @events = pagy(
      Event.includes(:region)
           .search(params[:search])
           .order("#{sort_column} #{sort_direction}, events.name")
           .distinct
      )
  end

  def create
    Event.create!(event_params)
    redirect_to admin_events_path
  end

  def update
    @event.update(event_params)
    redirect_to admin_events_path
  end

  def new
    @event = Event.new
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
