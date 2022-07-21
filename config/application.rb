require File.expand_path('../boot', __FILE__)
require "rails/all"

Bundler.require(*Rails.groups)
require 'rack/cors'
require './app/api/api/transaction_tracker.rb'

module CampaignManagement
  class Application < Rails::Application
    # config.load_defaults 6.1
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i(get post delete put patch options head)
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/services)

    config.eager_load_paths << Rails.root.join('lib')

    config.middleware.use API::TransactionTracker

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
  end
end
