class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:user].present?
      model = session[:user]['type'].classify.constantize
      @current_user ||= (model.find(session[:user]['id']))
    end
  end
  helper_method :current_user

  def require_user
    unless current_user
      flash[:notice] = "You have to log in, dude."
      session[:employee_requested_url] = request.url unless request.xhr?
      session[:employee_id] = nil
      redirect_to site_path and return false
    end
  end

  def require_customer
    unless current_customer
      flash[:notice] = "You have to log in, dude."
      session[:customer_requested_url] = request.url unless request.xhr?
      session[:customer_id] = nil
      redirect_to site_path and return false
    end
  end

end
