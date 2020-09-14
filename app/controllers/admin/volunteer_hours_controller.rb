# frozen_string_literal: true

class Admin::VolunteerHoursController < AdminController
	before_action :load_volunteer_hour, only: [:update_hour, :update_status]
  def index
    volunteer_hours = set_reviewed_status
    @pagy, @volunteer_hours = base_query(volunteer_hours)
  end

  def new
    @volunteer_hour = VolunteerHour.new
  end

  def create
    @volunteer_hour = VolunteerHour.new(volunteer_hour_params)
    if @volunteer_hour.save
      @volunteer_hour.update_attributes(status: VolunteerHour::ACCEPTED)
      flash[:success] = 'Volunteer hour saved, successfully!'
      redirect_to admin_volunteer_hours_path(reviewed: true)
    else
      flash[:alert] = 'Failed to save the volunteer hour.'
      redirect_to new_admin_volunteer_hour_path
    end
  end

  def unvolunteered_events
    user = User.find(params[:user_id])
    unvolunteered_events = Event.active - user.events

    respond_to do |format|
      format.json { render :json => unvolunteered_events.sort_by(&:name) }
    end
  end

  def filter_volunteer_hours
    volunteer_hours = set_reviewed_status
    if params[:school_year].present?
      @pagy, @volunteer_hours = pagy(
        volunteer_hours.includes(:event => :region)
                       .includes(:user)
                       .where(users: {school_year: params[:school_year]})
                       .order(sort_by_multiple_columns)
                       .references(:event)
                       .references(:user)
      )
    else
      @pagy, @volunteer_hours = base_query(volunteer_hours)
    end

    respond_to do |format|
      format.html { render action: :index }
      format.js {}
    end
  end

  def update_hour
    if params[:status].eql?(VolunteerHour::REJECTED)
      @volunteer_hour.update_attributes(status: VolunteerHour::ACCEPTED, time_worked: params['time_worked'].to_f)
    else
    	@volunteer_hour.update_attributes(time_worked: params['time_worked'].to_f)
    end
  	redirect_to admin_volunteer_hours_path
  end

  def update_status
    @volunteer_hour.update(status: params['status'])
    redirect_to admin_volunteer_hours_path
  end

  private

  def set_reviewed_status
    params[:reviewed] ||= 'false'
    if params[:reviewed].eql?('true')
      VolunteerHour.reviewed
    else
      VolunteerHour.pending_review
    end
  end

  def base_query(volunteer_hours)
    pagy(
      volunteer_hours.includes(:event => :region)
                    .includes(:user)
                    .order(sort_by_multiple_columns)
                    .references(:event)
                    .references(:user)
    )
  end

  def load_volunteer_hour
  	@volunteer_hour = VolunteerHour.find(params[:volunteer_hour_id])
  end

  def volunteer_hour_params
    params.require(:volunteer_hour).permit(:user_id, :event_id, :time_worked, :status)
  end
end
