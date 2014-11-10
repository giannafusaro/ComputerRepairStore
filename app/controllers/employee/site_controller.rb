class Employee::SiteController < ApplicationController
  before_filter :require_employee, except: :home
  layout "employee"

  def home
    if current_user.is_a?(Employee)
      redirect_to employee_dashboard_path
    end
  end
  
  def dashboard

  end

end
