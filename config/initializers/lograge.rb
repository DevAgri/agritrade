Rails.env.on(:production) do
  config.lograge.enabled = ENV['LOGRAGE'] === 'enabled'
  config.lograge.custom_options = lambda do |event|
    options = {time: event.time}
    options[:search] = event.payload[:searchkick_runtime] if event.payload[:searchkick_runtime].to_f > 0
    options
  end
end
