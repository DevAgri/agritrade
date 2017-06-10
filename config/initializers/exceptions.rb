# These files must be loaded here to be used
# before Rails load them with its autoload feature
require_relative '../../lib/middlewares/show_exceptions_as_json'

Rails.env.on(:any) do
  config.exceptions_app = Middlewares::ShowExceptionsAsJson.new
end
