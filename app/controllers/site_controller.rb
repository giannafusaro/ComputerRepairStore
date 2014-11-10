class SiteController < ApplicationController
  before_filter :require_customer, except: :home

  def home
    if current_user.is_a?(Customer)
      redirect_to dashboard_path
    end
  end

  def dashboard

  end

end
