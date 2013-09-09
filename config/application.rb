require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require 'sprockets/railtie'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module SassRailscrm
  class Application < Rails::Application

    # Generators to automatically generate using non-rails standard gems
    config.generators do |g|
      g.orm                 :mongoid
      g.template_engine     :haml
      g.test_framework      :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.stylesheets         false
      g.javascripts         false
      g.helper              false
      g.view_specs          false
      g.helper_specs        false
      g.controller_specs    false
      g.model_specs         false
    end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end

