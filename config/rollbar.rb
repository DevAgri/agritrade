require 'rollbar/rails'
require 'rollbar/logger'

Rails.logger.extend(ActiveSupport::Logger.broadcast(Rollbar::Logger.new))

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.enabled = Rails.env.production?
  config.exception_level_filters.merge!(
    'ActiveJob::DeserializationError' => 'warning',
    'ActionController::RoutingError'  => 'ignore'
  )
end
