# frozen_string_literal: true

class Admin::VolunteerHoursController < AdminController
	before_action :load_volunteer_hour, only: [:update_hour, :update_status]
  def index
    @volunteer_hour = VolunteerHour.new
    @pagy, @volunteer_hours = base_query
  end

  def filter_volunteer_hours
    if params[:school_year].present?
      @pagy, @volunteer_hours = pagy(
        VolunteerHour.includes(:event => :region)
                     .includes(:user)
                     .where(users: {school_year: params[:school_year]})
                     .order(sort_by_multiple_columns)
                     .references(:event)
                     .references(:user)
      )
    else
      @pagy, @volunteer_hours = base_query
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

  def base_query
    pagy(
      VolunteerHour.includes(:event => :region)
                   .includes(:user)
                   .order(sort_by_multiple_columns)
                   .references(:event)
                   .references(:user)
    )
  end

  def load_volunteer_hour
  	@volunteer_hour = VolunteerHour.find(params[:volunteer_hour_id])
  end
end
