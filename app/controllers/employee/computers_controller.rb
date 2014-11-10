class Employee::ComputersController < ApplicationController
  before_filter :require_employee
  layout "employee"
end
