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

  def take_ownership
    @repair = Repair.find(params[:id])
    if @repair && current_user.is_a?(Employee)
      @repair.employee = current_user
      if @repair.save
        flash[:notice] = "Repair assigned!"
      end
    else
      flash[:notice] = "Whoops, something went wrong. Try again."
    end
    redirect_to employee_dashboard_path
  end

end
