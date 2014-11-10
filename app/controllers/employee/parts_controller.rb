class Employee::PartsController < ApplicationController
  before_filter :require_employee
  layout "employee"
end
