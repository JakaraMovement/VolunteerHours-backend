class Dashboard::WelcomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@total_hours_volunteered = current_user.volunteer_hours.pluck(:time_worked).reduce(:+) || 0
  end
end
