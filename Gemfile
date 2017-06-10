source 'https://rubygems.org'

ruby '2.2.6'

gem 'rails', '4.2.4'
gem 'pg', '~> 0.18'
gem 'sidekiq', '~> 3.3'
gem 'clockwork', '~> 1.2'
gem 'ar-uuid', '~> 0.1'
gem 'rollbar', '~> 2.4'
gem 'dotenv-rails', '~> 2.0'
gem 'rack-cors', '~> 0.4', require: 'rack/cors'
gem 'lograge', '~> 0.3'
gem 'versionist', '~> 1.4'
gem 'http_accept_language', '~> 2.0'
gem 'roar-rails', '~> 1.0', '< 1.1.0'
gem 'bcrypt', '~> 3.1'
gem 'pundit', '~> 1.0'
gem 'phony_rails', '~> 0.14'
gem 'kaminari', '~> 0.16'
gem 'jwt', '~> 1.5'
gem 'public_activity', '~> 1.4'
gem 'browser', '~> 1.0'
gem 'koala', '~> 2.0'
gem 'mini_magick', '~> 4.2'
gem 'refile', '~> 0.5', require: 'refile/rails', github: 'refile/refile'
gem 'refile-mini_magick', '~> 0.1'
gem 'refile-s3', '~> 0.1'
gem 'aws-sdk', '~> 2.0'
gem 'email_prefixer', '~> 1.1'
gem 'has_scope', '~> 0.6'
gem 'nokogiri', '~> 1.6'
gem 'wannabe_bool', '~> 0.1'
gem 'rails-env', '~> 1.0'
gem 'devise', '~> 3.5'
gem 'activeadmin', github: 'activeadmin'
gem 'chosen-rails'
gem 'ancestry'

gem 'validates_email_format_of', '~> 1.6'
gem 'validates_cpf_cnpj', '~> 0.2'

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'sinatra', require: nil
end

group :test, :production do
  gem 'puma', '~> 2.12'
  gem 'rack-timeout', '~> 0.3'
  gem 'newrelic_rpm'
end
