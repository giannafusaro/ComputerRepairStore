class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    Rails.logger.debug "==================================="
    Rails.logger.debug session[:user].inspect
    Rails.logger.debug "==================================="
    if session[:user].present?
      model = session[:user]['type'].classify.constantize
      @current_user ||= (model.find(session[:user]['id']))
    end
  end
  helper_method :current_user

  def require_customer
    unless current_user.present? && current_user.is_a?(Customer)
      flash[:notice] = "You have to log in, dude."
      session[:user] = nil
      redirect_to site_path and return false
    end
  end

  def require_employee
    unless current_user && current_user.is_a?(Employee)
      flash[:notice] = "You have to log in as an employee, dude."
      session[:user] = nil
      redirect_to employee_site_path and return false
    end
  end

end
