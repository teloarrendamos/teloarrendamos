class Users::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @listings = current_user.listings
  end
end