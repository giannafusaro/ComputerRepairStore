class RepairsController < ApplicationController
  before_filter :require_customer

  def index
    @repairs = Repair.all
  end

  def create
    @repair = current_user.repairs.new repair_params
    # @repair.requested_for = @repair.requested_for + params[:offset].to_i.hours

    if @repair.save
      flash[:notice] = "Repair appointment created successfully!"
      redirect_to :site
    else
      render :new
    end
  end

  def new
    @repair = current_user.repairs.new
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
      redirect_to :site
    else
      render :edit
    end
  end

  def destroy
    @repair = Repair.find(params[:id]).destroy
    flash[:notice] = "Repair appointment destroyed successfully."
    redirect_to :site
  end

  def rate
    @repair = Repair.find(params[:id])
    @repair.rating = params[:rating]
    if @repair.save
      flash[:notice] = "Rating for repair saved succesfully!"
    else
      flash[:notice] = "Something went wrong, try rating again."
    end
    redirect_to :site
  end

  private

    def repair_params
      params.require(:repair).permit(:customer_id, :employee_id, :computer_id, :description, :labor_cost, :total_cost, :offset, :requested_for, :completed_at)
    end
end
