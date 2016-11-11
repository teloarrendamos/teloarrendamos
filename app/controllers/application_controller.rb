class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  devise_group :person, contains: [:user, :company]
end
