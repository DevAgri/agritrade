workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  if defined?(ActiveRecord::Base)
    config = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 5
    ActiveRecord::Base.establish_connection(config)
  end

  Redis.current = Redis.new(url: ENV['REDIS_URL']) if defined?(Redis)
end

on_restart do
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)

  Redis.current.quit if defined?(Redis)
end
