# Load the Rails application.
require File.expand_path('../application', __FILE__)
require File.expand_path('../rollbar', __FILE__)

# Initialize the Rails application.
begin
  Rails.application.initialize!
rescue Exception => e
  Rollbar.error(e)
  raise
end
