class OrdersController < ApplicationController
  def index
    @orders = current_person.orders.includes(order_items: :listing)
  end
end