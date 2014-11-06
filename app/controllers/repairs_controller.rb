class RepairsController < ApplicationController

  def index
    @repairs = Repair.all
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def destroy
  end

private
    def repairs_params
      params.require(:repairs).permit(:customer_id, :employee_id, :computer_id, :description, :labor_cost, :total_cost, :status)
    end
end
