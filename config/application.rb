require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RentalApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  	config.assets.paths << Rails.root.join("app", "assets", "fonts")
  	config.assets.precompile << /\.(?:otf|eot|woff|ttf)$/
    
    config.i18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
 
    config.i18n.available_locales = ['es-CL', 'en']
    config.i18n.default_locale = :"es-CL"
    config.i18n.fallbacks = [:en]
    
  end
end