# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Redirect admin users to the admin dashboard
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      super
    end
  end
end
