class CartsController < ApplicationController
  before_action :store_current_location
  before_action :authenticate_person!

  def show
    @order = current_order
    @order_items = current_order.order_items
  end

  private
  def store_current_location
    store_location_for(:person, request.url)
  end
end
