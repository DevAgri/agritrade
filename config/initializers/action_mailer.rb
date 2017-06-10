Rails.env.on(:development) do
  config.action_mailer.default_url_options = {
    host: 'localhost',
    port: 3000
  }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'localhost',
    port: 1025
  }
end

Rails.env.on(:test, :production) do
  config.action_mailer.default_url_options = {
    host: 'agritrade.codigo5.com.br'
  }
end

Rails.env.on(:production) do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV['SENDER_ADDRESS'],
    port: ENV['SENDER_PORT'],
    user_name: ENV['SENDER_USER_NAME'],
    password: ENV['SENDER_PASSWORD'],
    authentication: :plain,
    enable_starttls_auto: true,
    openssl_verify_mode: 'none'
  }
end

ActionMailer::DeliveryJob.queue_as(:low)
