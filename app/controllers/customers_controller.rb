class CustomersController < ApplicationController
  before_filter :require_customer, :except => [:login, :signup]

  def login
    if current_user
      redirect_to dashboard_path
    else
      if request.post?
        if @customer = Customer.find_by_email(params[:customer][:email])
          if @customer.authenticate(params[:customer][:password])
            session[:user] = {id: @customer.id, type: "customer"}
            redirect_to dashboard_path
          else
            flash.now[:notice] = "Your password is incorrect."
            render 'site/home'
          end
        else
          flash.now[:notice] = "There is no user with that login."
          render 'site/home'
        end
      end
    end
  end

  def index
  end

  def signup
    if request.post?
      @customer = Customer.new customer_params
      if @customer.save
        session[:user] = {id: @customer.id, type: "customer"}
        session[:customer_id] = @customer.id
        flash[:notice] = "You're signed up! Welcome to FixNow.Me!"
        redirect_to dashboard_path
      else
        render 'site/home'
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = "You are now logged out"
    redirect_to site_path
  end

  private

    def customer_params
      params.require(:customer).permit(:name, :email, :phone, :password, :password_confirmation)
    end

end
