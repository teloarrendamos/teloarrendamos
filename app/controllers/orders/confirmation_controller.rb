class Orders::ConfirmationController < ApplicationController
  before_action :authenticate_person!

  def create
    @order = Order.find(params[:order_id])
    @order.orderable = current_person
    @order.save
    @order.placed!
    session[:order_id] = nil

    # Send email to ordering user
    OrderConfirmationNotifierMailer.send_confirmation_email(@order).deliver

    @order_items = @order.order_items.includes(listing: :postable)

    # Send email to each poster
    @groups = @order_items.group_by {|oi| oi.listing.postable}
    @posters = @groups.keys

    @posters.each do |poster|
      OrderConfirmationNotifierMailer.send_confirmation_email_to_poster(poster, @groups[poster], @order).deliver
    end

    redirect_to orders_path
  end
end