# frozen_string_literal: true

class Admin::VolunteerRequestsController < AdminController
  def index
    @volunteer_requests = VolunteerHour.all
  end
end
