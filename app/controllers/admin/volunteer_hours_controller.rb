# frozen_string_literal: true

class Admin::VolunteerHoursController < AdminController
	before_action :load_volunteer_hour, only: [:update_hour, :update_status]
  def index
    @volunteer_hour = VolunteerHour.new
    @volunteer_hours = VolunteerHour.all
  end

  def update_hour
  	@volunteer_hour.update(time_worked: params['time_worked'].to_i)
  	redirect_to admin_volunteer_hours_path
  end

  def update_status
    @volunteer_hour.update(status: params['status'])
    redirect_to admin_volunteer_hours_path
  end

  private

  def load_volunteer_hour
  	@volunteer_hour = VolunteerHour.find(params[:volunteer_hour_id])
  end
end
