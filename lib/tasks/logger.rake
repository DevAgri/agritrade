desc 'Switch rails logger to stdout'
task verbose: :environment do
  Rails.logger = Logger.new STDOUT
end

desc 'Switch rails logger log level to debug'
task debug: [:environment, :verbose] do
  Rails.logger.level = Logger::DEBUG
end
