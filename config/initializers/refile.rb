require 'refile/s3'

Refile.configure do |config|
  config.cdn_host = 'http://localhost:3000' if Rails.env.development?

  config.backends['local_cache'] = Refile::Backend::FileSystem.new(Rails.root.join('tmp/uploads/cache').to_s)
  config.backends['local_store'] = Refile::Backend::FileSystem.new(Rails.root.join('tmp/uploads/store').to_s)

  if Rails.env.production?
    config.cdn_host = 'http://' + Rails.application.config.action_controller.asset_host

    aws = {
      max_size: 5.megabytes,
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      bucket: ENV['AWS_BUCKET'],
      region: ENV['AWS_REGION'] || 'us-west-2'
    }

    config.cache = Refile::S3.new(prefix: 'cache/default', **aws)
    config.store = Refile::S3.new(prefix: 'store/default', **aws)

    config.backends['product_cache'] = Refile::S3.new(prefix: 'cache/products', **aws)
    config.backends['product_store'] = Refile::S3.new(prefix: 'store/products', **aws)
  else
    config.backends['product_cache'] = config.backends['local_cache']
    config.backends['product_store'] = config.backends['local_store']
  end

  config.app_host = config.cdn_host
end
