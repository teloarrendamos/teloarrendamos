class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  devise_group :person, contains: [:user, :company]
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
end
