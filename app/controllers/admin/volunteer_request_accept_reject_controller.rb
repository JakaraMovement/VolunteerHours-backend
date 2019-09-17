# frozen_string_literal: true

class Admin::VolunteerRequestAcceptRejectController < AdminController
  def update
    VolunteerHour.find(params[:id]).update(status: params['status'])
    redirect_to admin_volunteer_requests_path
  end
end
