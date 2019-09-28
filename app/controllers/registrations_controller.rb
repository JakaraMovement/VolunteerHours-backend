class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    resource.admin? ? admin_path : dashboard_path
  end
end
