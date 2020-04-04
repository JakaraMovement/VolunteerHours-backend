class Dashboard::WelcomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@page_title = "Volunteer's Dashboard"
  end
end
