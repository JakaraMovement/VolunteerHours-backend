# frozen_string_literal: true

class Admin::VolunteerHoursController < AdminController
	before_action :load_volunteer_hour, only: [:update_hour, :update_status]
  def index
    @volunteer_hour = VolunteerHour.new
    @volunteer_hours = VolunteerHour.all
  end

  def update_hour
    if params[:status].eql?('rejected')
      @volunteer_hour.update_attributes(status: 'accepted', time_worked: params['time_worked'].to_f)
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

  def load_volunteer_hour
  	@volunteer_hour = VolunteerHour.find(params[:volunteer_hour_id])
  end
end
