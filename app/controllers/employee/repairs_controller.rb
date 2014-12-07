class Employee::RepairsController < ApplicationController
  before_filter :require_employee
  layout 'employee'

  def index
    @repairs = Repair.all
  end

  def create
    @repair = current_user.repairs.new repair_params

    if @repair.save
      flash[:notice] = "Repair appointment created successfully!"
      redirect_to edit_employee_repair_path(@repair)
    else
      render :new
    end
  end

  def new
    @repair = Repair.new
  end

  def edit
    @repair = Repair.find(params[:id])
  end

  def show
    @repair = Repair.find(params[:id])
  end

  def update
    @repair = Repair.find params[:id]
    if @repair.update_attributes(repair_params)
      flash[:notice] = "Repair appointment updated successfully!"
      redirect_to edit_employee_repair_path(@repair)
    else
      render :edit
    end
  end

  def destroy
    @repair = Repair.find(params[:id]).destroy
    flash[:notice] = "Repair appointment destroyed successfully."
    redirect_to :site
  end

  private

    def repair_params
      params.require(:repair).permit(:customer_id, :employee_id, :computer_id, :description, :labor_cost,
        :total_cost, :offset, :requested_for, computer_attributes: [ :type, :model, :serial, :warranty, :purchased_at, :offset ])
    end
end
