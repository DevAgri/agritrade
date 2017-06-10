Rails.env.on(:production) do
  Rack::Timeout.timeout = Integer(ENV['TIMEOUT'] || 15)
end
