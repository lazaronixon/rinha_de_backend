require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RinhaDeBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.delete ActionDispatch::HostAuthorization
    config.middleware.delete Rack::Sendfile
    config.middleware.delete ActionDispatch::Static
    config.middleware.delete ActionDispatch::Executor
    config.middleware.delete ActionDispatch::ServerTiming
    config.middleware.delete Rack::Runtime
    config.middleware.delete ActionDispatch::RequestId
    config.middleware.delete ActionDispatch::RemoteIp
    config.middleware.delete Rails::Rack::Logger
    config.middleware.delete ActionDispatch::ShowExceptions
    config.middleware.delete ActionDispatch::DebugExceptions
    config.middleware.delete ActionDispatch::ActionableExceptions
    config.middleware.delete ActionDispatch::Reloader
    config.middleware.delete ActionDispatch::Callbacks
    # config.middleware.delete ActiveRecord::Migration::CheckPending
    # config.middleware.delete Rack::Head
    config.middleware.delete Rack::ConditionalGet
    config.middleware.delete Rack::ETag
  end
end
