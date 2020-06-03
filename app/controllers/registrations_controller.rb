class RegistrationsController < Devise::RegistrationsController
  def create
  	super do
  		birth_date = "#{params[:birth_month]} #{params[:birth_day]}, #{params[:birth_year]}"
  		resource.birthday = Date.parse(birth_date) if params[:birth_month].present?
  		resource.save
  	end
  end

  protected

  def after_sign_up_path_for(resource)
    resource.admin? ? admin_path : dashboard_path
  end
end
