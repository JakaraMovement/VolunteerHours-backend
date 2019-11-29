class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :email, :password, :last_name, :address, :birthday, :gender, :phone, :city, :state, :zip_code, :parent_email, :parent_first_name, :parent_last_name, :parent_phone, :school_year) }
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth) }
	end

	def after_sign_in_path_for(resource)
		resource.admin? ? admin_events_path : filter_dashboard_events_path(upcoming_events: true)
	end
end
