class Employee::EmployeesController < ApplicationController
  before_filter :require_employee, except: :login
  layout "employee"

  def login
    if current_user.is_a?(Employee)
      redirect_to employee_dashboard_path
    else
      if request.post?
        if @employee = Employee.find_by_email(params[:employee][:email])
          if @employee.authenticate(params[:employee][:password])
            session[:user] = {id: @employee.id, type: "employee"}
            redirect_to employee_dashboard_path
          else
            flash.now[:notice] = "Your password is incorrect."
            render 'employee/site/home'
          end
        else
          flash.now[:notice] = "There is no employee with that login."
          render 'employee/site/home'
        end
      end
    end
  end

  def logout
  end

end
