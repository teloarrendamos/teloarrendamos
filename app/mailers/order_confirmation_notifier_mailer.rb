class OrderConfirmationNotifierMailer < ApplicationMailer
  default :from => 'admin@teloarrendamos.com'

  def send_confirmation_email(order)
    @order = order
    @order_items = @order.order_items.includes(listing: :postable)
    mail(to: @order.orderable.email, subject: "Orden Confirmada!")
  end

  def send_confirmation_email_to_poster(poster, order_items, order)
    @order = order
    @poster = poster
    @order_items = order_items
    mail(to: poster.email, subject: "Tu articulo ha sido arrendado!")
  end
end
