class Employee::PartsController < ApplicationController
  before_filter :require_employee
  layout "employee"

  def new
    @repair = Repair.find params[:repair_id]
    @part = @repair.parts.new
  end

  def create
    @repair = Repair.find params[:repair_id]
    @part = @repair.parts.new part_params

    if @part.save
      flash[:notice] = "Part created successfully!"
      redirect_to edit_employee_repair_path(@repair)
    else
      render :new
    end
  end

  def edit
    @repair = Repair.find params[:repair_id]
    @part = @repair.parts.find params[:id]
  end

  def update
    @repair = Repair.find params[:repair_id]
    @part = @repair.parts.find params[:id]

    if @part.update_attributes(part_params)
      flash[:notice] = "Part updated successfully!"
      redirect_to edit_employee_repair_path(@repair)
    else
      render :edit
    end
  end

  def destroy
    @repair = Repair.find params[:repair_id]
    @part = @repair.parts.find params[:id]
    @part.destroy

    flash[:notice] = "Part destroyed successfully."
    redirect_to edit_employee_repair_path(@repair)
  end

  private

    def part_params
      params.require(:part).permit(:model, :serial, :cost, :quantity)
    end

end
