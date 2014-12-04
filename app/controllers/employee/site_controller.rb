class Employee::SiteController < ApplicationController
  before_filter :require_employee, except: :home
  layout "employee"

  def home
    if current_user.is_a?(Employee)
      redirect_to employee_dashboard_path
    end
  end

  def dashboard
    connection = Repair.connection
    connection.execute "CALL avg_TurnAroundTime(@average);"
    result = connection.execute "SELECT @average;"
    @avg_tat = result.each[0][0].to_f.round(2)
  end

end
