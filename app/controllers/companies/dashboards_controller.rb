class Companies::DashboardsController < ApplicationController
  before_action :authenticate_company!

  def show
    @listings = current_company.listings 
  end
end